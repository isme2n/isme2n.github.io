---
layout: post
title:  "[함수형 자바스크립트]4. 재사용 가능한 모듈로"
subtitle:   "함수형 자바스크립트"
categories: devlog
tags: nodejs javascript

---

> 잘 작동하는 복잡한 시스템은 열이면 아홉 잘 작동했던 단순한 시스템에서 진화한 경우가 많다.

대규모 프로젝트에서 모듈성은 아주 중요한 특성이다. 프로그램을 더 작고 독립적인 부분으로 나눌 수 있는 정도를 뜻하는 모듈성은 재사용 가능한 컴포넌트를 만드는데 주요하다. 재사용 가능하다는 것은 다시 만들지 않아도 된다는 뜻으로 잘 만들어둔 모듈 하나는 평생 사용할 수도 있다.

## 메서드 체인 대 함수 파이프라인

> tip: 함수형을 표기할때는 하스켈 표기법을 자주 사용한다. `<function-name> :: <inputs> -> <output>`

### 메서드 체이닝 (단단한 결합, 제한된 표현성)

```js
_.chain(persons)
    .filter(isValid)
    .map(_.property('address.country'))
    .reduce(gatherStats, {})
    .values()
    .sortBy('count')
    .reverse()
    .firse()
    .value()
    .name; // 'US'
```

이전에 만들었던 코드가 메서드 체이닝의 예이다.이는 로대시가 제공하는 연산만 쓸 수 있기때문에 다른 함수를 연결하기 쉽지 않다.

### 함수 파이프라인 배열 (느슨한 결합, 유연성)

파이프라인은 함수 입출력을 서로 연결지어 느슨하게 결합된 컴포넌트를 만든다. 인수의 개수와 형식이 호환되지 않으면 연결할 수 없기 때문에 주의해야한다.

## 함수 호환 요건

각 함수는 두가지 측면에서 입력과 출력이 서로 호환되어야 한다.

- 형식: 한 함수의 반환 형식과 수신 함수의 인쑤 형식이 일치해야한다.
- 항수: 수신 함수는 앞 단계 함수가 반환된 값을 처리하기 위해 적어도 하나 이상의 매개변수를 선언해야 한다.

### 형식이 호환되는 함수

하스켈 표기법으로 선행 함수의 출력과 후행함수의 입력이 같은 타입이면 된다.

### 함수와 항수: 튜플

`항수`란 함수가 받는 인수의 개수이다. 함수의 길이라고도 한다. 이 항수가 작을수록 단순한 함수라고 볼 수 있다.

항수가 1인 함수가 가장 유연하고 좀 더 모듈화되었다고 볼 수 있다. 하지만 항수가 1인 함수를 얻기란 쉬운일이 아니다.

```js

isValid('444-444-4444') // (false, 'too long')

```

`isValid`의 출력에 에러메세지까지 포함 한다고 해보자. 이때 두가지 다른 값을 반환한 자료구조를 튜플이라고 한다.

튜플은 유한 원소를 지닌 정렬된 리스트로, 보통 한번에 두세 개 값을 묶어 `(a, b , c)`와 같이 쓴다. 

튜플은 다음과 같은 특징을 가진다.

- 불변성: 한번 만들어지면 바꿀 수 없다.
- 임의 형식 생성 방지: 튜플은 전혀 무관한 값을 서로 연관 지을 수 있다. 새로운 인터페이스를 만들지 않아도 된다.
- 이형배열 생성 방지: 자바스크립트는 형식이 다른 원소를 배열에 함께 포함할 수 있다. 하지만 형식이 다른 원소가 배열에 섞여 있으면 형식을 검사하는데 어려움이 있다. 배열은 동일한 형식을 담는 자료구조일 때만 쓰도록 하자.

## 커리된 함수의 평가

자바스크립트는 언어 특성상 다항함수의 인자가 전부 전해지지 않아도 `undefined`를 세팅한다. f(a, b, c)에서 a만 전해지면 f(a, 'undefined', 'undefined')가 되는것이다. 이런 경우는 생각보다 위험하다.

이때 커리된 함수를 사용하면 일부 인수만 넣어 호출하면 모자란 나머지 인수가 채워지기를 기다리는 새로운 함수가 반환된다. 

> f(a) -> f(b,c)

### 재사용 가능한 함수 템플릿을 구현하는데 쓰이는 커리

log4js를 이용해 로그를 찍는 모듈을 만들어보자.

```js
const logger = function(appender, layout, name, level, message) {
    const appenders = {
        'alert': new Log4js.JSAlertAppender(),
        'console': new Log4js.BrowserConsoleAppender()
    }
}

const layouts = {
    'basic': new Log4js.BasicLayout(),
    'json': new Log4js.JSONLayout(),
    'xml': new Log4js.XMLLayout()
}

const appender = appenders[appender];
appender.setLayout(layouts[layout]);
const logger = new Log4js.getLogger(name);
logger.addAppender(appender);
logger.log(level, message, null);

const log = R.curry(logger)('alert', 'json', 'FJS'); // R은 람다js. level과 message를 빼고 호출했다.ㄴ
log('ERROR', 'Error Occurred!!');

const logError = R.curry(logger)('console', 'basic', 'FJS', 'ERROR');
logError('404 Error Occurred!');
```

아마 이 예제로 객체지향적 프로그래밍을 하던 사람들은 꽤 와닿았을 것 같다.

## 부분 적용과 매개변수 바인딩

부분 적용(partial)은 함수의 일부 매개변수 값을 처음부터 고정시켜 항수가 더 작은 함수를 생성하는 기법이다. 커링과 마찬가지로 함수의 길이를 줄이는 방법이지만 조금 다르다.

- 커링은 부분 호출할 때마다 단항 함수를 중첩 생성하며, 내부적으로는 이들을 단계별로 합성하여 최종 결과를 낸다. 커링은 여러인수를 부분 평가하는 식으로도 변용할 수 있어서 개발자가 평가 시점과 방법을 좌지우지 할 수 있다.
- 부분 적용은 함수 인수를 미리 정의된 값으로 할당한 후, 인수가 적은 함수를 새로 만든다. 이 결과 함수는 자신의 클로저에 고정된 매개변수를 갖고 있으며, 후속 호출 시 이미 평가를 마친 상태이다.

```js
const consoleLog = _.partial(logger, 'console', 'json', 'FJS partial');

const consoleInfoLog = _.partial(consoleLog, 'INFO');

consoleInfoLog('INFO logger using partial');
```

커링은 파셜의 자동화기법이라고 봐도 된다. 

## 함수 파이프라인 합성

사이드이펙트를 없앤 순수함수의 합성이 함수형 프로그래밍의 가장 큰 목적이라고 할 수 있다.

### 함수 합성: 서술과 평가를 구분

```js
const explode = (str) => str.split(/\s+/);
const count = (arr) => arr.length;
const countWords = R.compose(count, explode);

countWords(str);
```

`countWords(str)`이 실행되기 전까지 이 함수는 구동되지 않는다. 서술부와 평가부가 분리되어 있다고 볼 수 있다.

### 순수/불순 함수 다루기

함수형 프로그래밍을 한다고해서 모두 순수함수만 존재하는건 아니다. 거의 불가능하기때문에 그걸 인정하고 불순한 코드와 순수한 코드를 잘 분리해서 격리하는 것이 중요하다.

## 함수 조합기로 제어 흐름 관리하기

함수 조합기는 자주쓰이는 건 아래와 같다.

- compose
- pipe
- identity
- tap
- alternation
- sequence
- fork or join

이중 compose와 pipe는 비슷하니 넘어가고 이야기해보자.

### identity

`identity`는 주어진 인수와 똑같은 값을 반환하는 함수이다.

`identity :: (a) -> a`

주로 함수의 수학적 속성을 살펴보는 용도로 쓰이지만 실용적인 쓰임새도 있다.

### 탭

탭은 코드 추가 없이 void함수를 연결하여 합성할때 유용하다. 자신을 함수에 넘기고 자신을 돌려받는다.

`tap :: (a -> *) -> a  -> a`

```js
const debugLog = _.partial(logger, 'console', 'basic', 'MyLogger', 'DEBUG');

const debug = R.tap(debugLog);
const cleanInput = R.compose(normalize, debug, trim);
const isValidSsn = R.compose(debug, checkLengthSsn, debug, cleanInput);

isValidSsn('444-44-4444');

/*
    MyLogger [DEBUG] 444-44-4444
    MyLogger [DEBUG] 444444444
    MyLogger [DEBUG] true
*/
```

### 선택

alt는 함수 호출 시 기본 응답을 제공하는 단순 조건 로직을 수행한다. 함수 2개를 인수로 받아 값이 있으면 첫번째 함수의 결과를, 그렇지 않으면 두번째 함수를 반환한다. `OR`라고 생각하면 된다.

### 순차

seq는 함수 순차열을 순회한다. 2개 또는 더 많은 함수를 인수로 받아 동일한 값에 대해 각 함수를 차례로 실행하는 또 다른 함수를 반환한다.

`seq(append('#student-info'), consoleLog);`

### 포크(조인)

fork는 하나의 자원을 두가지 방법으로 처리 후 그 결과를 다시 조합한다. 하나의 join 함수와 주어진 입력을 처리할 종단 함수 2개를 받는다. 분기된 각 함수의 결과는 제일 마지막에 인수 2개를 받는 join 함수에 전달된다.

```js

const computeAverageGrade = R.compose(getLetterGrade, fork(R.divide, R.sum, R.length));

computeAverageGrade([99, 80, 89]); // 'B'

```



