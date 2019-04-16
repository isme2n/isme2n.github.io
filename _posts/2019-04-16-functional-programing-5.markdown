---
layout: post
title:  "[함수형 자바스크립트]5.복잡성을 줄이는 디자인 패턴"
subtitle:   "함수형 자바스크립트"
categories: devlog
tags: nodejs javascript

---

함수형 패러다임이 다른 패러다임보다 에러를 더 깔끔하게 처리한다는 의견이 많다.

프로그램 실행 중 예외가 나거나 네트워크 연결이 끊기는 등 예기치 않은 사고로 인해 데이터가 `null, undefined`가 되는 경우 골치아픈 문제들이 발생할 수 있다. 이런 에러처리를 위해 개발자들은 아주 많은 리소스를 사용한다. 그렇게 덩치가 커진 코드는 수수께끼 같은 코드가 되기 마련이다.

모나드라는 기법을 사용하여 이 문제에 대해 다뤄보자.

## 명령형 에러 처리의 문제점

명령형 코드는 대부분 `try-catch` 구문으로 에러를 처리한다. 하지만 `try-catch`를 사용하면 다른 함수와 합성/체이닝을 할 수 없고 코드 설계에서도 어려움을 갖는다.

### 함수형 프로그램은 왜 예외를 던지지 않을까?

명령형에서 예외를 던지는 함수의 특징은 다음과 같다.

- 다른 함수형 장치처럼 합성이나 체이닝을 할 수 없다.
- 예외를 던지는 행위는 함수 호출에서 빠져나갈 구멍을 찾는 것이므로 예측가능한 값을 지향하는 참조 투명성에 위배된다.
- 예기치 않게 스택이 풀리면 함수 호출 범위를 벗어나 전체 시스템에 영향을 미치는 사이드이펙트를 일으킨다.
- 에러를 조치하는 코드가 당초 함수를 호출한 지점과 동떨어져 있어서 비지역성원리에 위배된다. 에러가 나면 함수는 지역 스택과 환경에서 벗어난다.
- 함수의 단일 반환값에 신경 써야 할 에너지를 catch 블록을 선언해 예외를 붙잡아 처리하는데 낭비하게 되어 호출자의 부담이 가중된다.
- 다양한 에러 조건을 처리하는 블록들이 중첩되어 사용하기 어렵다.

그렇다면 함수형 프로그래밍에서는 예외를 완전히 없애야할까?

### Null 체크

함수가 null을 반환하면 이 함수를 부른 호출자는 null체크를 해야 하는 부담을 떠안게된다.

## 함수자

try-catch와 비슷하게 잠재적인 위험을 가진 코드를 컨테이너로 감싸면서 함수형 에러처리를 할 수 있다.

### 불안전한 값을 감싼다

래퍼함수를 만들어서 에러가 날지 모를 값을 감싸는 것이다. 이 경우 값에 직접 접근할 수 없어 identity를 사용해야한다.

## 모나드를 응용한 함수형 에러 처리

모나드는 제이쿼리를 사용해봤다면 비슷한 개념이다. 선택자가 잘못된 값을 선택해도 예외를 던지는게 아니라 빈 제이쿼리 객체에 메서드를 적용하는 걸 생각하면 된다.

### 제어흐름에서 데이터흐름으로

모나드는 다음 인터페이스를 준수해야한다.

- 형식생성자: 모나드형을 생성한다.
- 단위 함수: 어떤 형식의 값을 모나드에 삽입한다.
- 바인드함수: 연산을 서로 체이닝한다.
- 조인연산: 모나드 반환함수를 다중합성할때 중요하게 쓰인다.

```js
// Wrapper Monad

class Wrapper {
    constructor(value) { // 형식 생성자
        this._value = value;
    }

    static of(a) { // 단위 함수
        return new Wrapper(a);
    }

    map(f) { // 바인드 함수
        return Wrapper.of(f(this._value));
    }

    join() { // 조인 연산
        if(!(this._value instanceof Wrapper)) {
            return this;
        }
        return this._value.join;
    }

    get() {
        return this._value;
    }

    toString() {
        return `Wrapper (${this._value})`;
    }
}

```

### Maybe와 Either 모나드로 에러 처리

모나드는 유효한 값을 감싸기도 하지만 값이 없는 상태, null이나 undefined를 모형화할 수 있다. 함수형 프로그래밍에서는 Maybe/Either로 아래와 같은 일들을 처리한다.

- 불순 코드 격리
- null 체크 로직 정리
- 예외를 던지지 않음
- 함수 합성 지원
- 기본값 제공 로직을 한곳에 모음

#### null 체크를 Maybe로 일원화

Maybe 모나드는 Just, Nothing 두 하위형으로 구성된 빈 형식으로, 주로 null 체크로직을 효과적으로 통합한다.

- Just(value): 존재하는 값을 감싼 컨테이너를 나타낸다.
- Nothing(): 값이 없는 컨테이너 또는 추가 정보없이 실패한 컨테이너를 나타낸다.

Maybe 모나드는 DB쿼리, 컬렉션에서 값을 검색하거나 서버에 데이터를 요청하는 등 결과가 불확실한 호출을 할 때 자주사용한다. 

```js

const safeFindObject = R.curry((db, id) => Maybe.fromNullable(find(db, id)));

const safeFindStudent = safeFindObject(DB('student'))

const address = safeFindStudent('444-44-4444').map(R.prop('address'));

address; // Just(Address(...)) or Nothing
```

```js
const country = R.compose(getCountry, safeFindStudent);
const getCountry = (student) => student
    .map(R.prop('school'))
    .map(R.prop('address'))
    .map(R.prop('country'))
    .getOrElse('존재하지 않는 국가입니다'); // 어느 하나라도 Nothing이면 다른 연산은 건너뛴다.
```
#### 함수 승급

모든 함수마다 일일이 모나드를 부착해야할까? 이런 작업을 간략화하기위해 lift라는 함수 승급기법이 있다.

```js
const lift = R.curry((f, value) => Maybe.fromNullable(value)).map(f);

const safeFindObject = R.compose(lift(console.log), findObject);
```

#### Either로 실패 복구

Either는 Maybe와 조금 다르다. Either는 절대로 동시에 발생하지 않는 두 값을 논리적으로 구분한 자료구조이다.

- Left(a): 에러 메시지 또는 예외 객체를 담는다.
- Right(b): 성공한 값을 담는다.

즉 실패하면 왼쪽을 보고 성공하면 오른쪽을 보면 된다.

```js
const safeFindObject = R.curry((db, id) => {
    const obj = find(db, id);
    if(obj) {
        return Either.of(obj);
    }
    return Either.left(`ID가 ${id}인 객체를 찾을 수 없습니다.`);
})

const findStudent = safeFindObject(DB('student'));
findStudent('444-44-4444').getOrElse(new Student());

const errorLogger = _.partial(logger, 'console', 'basic', 'MyErrorLogger', 'Error');
fineStudent('444-44-4444').orElse(errorLogger);
```

### IO 모나드로 외부 자원과 상호작용

DOM을 읽고쓰는 예제를 보자.

```js
const read = (document, selector) => {
    () => document.querySelector(selector).innerHTML;
}

const write = (document, selector) => {
    return (val) => {
        document.querySelector(selector).innerHTML = val;
        return val;
    }
}

// document를 미리 할당하도록 부분적용

const readDom = _.partial(read, document);
const writeDom = _.partial(write, document);

const changeToStartCase = IO.from(readDom('#student-name'))
    .map(_.startCase)
    .map(writeDom('#student-name'));

changeToStartCase.run();
```

run()을 할때서 한번에 실행되기 때문에 읽기쓰기 중간에 불순한 일이 생길 수 없다.

## 모나드 체인 및 합성

모나드는 사이드이펙트를 억제하므로 합성 가능한 자료구조로 활용할 수 있다. 

```js
const liftIO = (val) => {
    return IO.of(val)
}

const getOrElse = R.curry((message, container) => container.getOrElse(message));

const showStudent = R.compose(
    map(append('#student-info')),
    liftIO,
    getOrElse('Can not find student'),
    map(csv),
    map(R.props(['ssn', 'firsename', 'lastname'])),
    chain(findStudent),
    chain(checkLengthSsn),
    lift(cleanInput)    
)

```