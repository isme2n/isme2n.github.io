---
layout: post
title:  "[함수형 자바스크립트]8.비동기 이벤트와 데이터 관리"
subtitle:   "함수형 자바스크립트"
categories: devlog
tags: nodejs javascript

---

요즘 자바스크립트 프로그램은 단일 요청으로 로드되는 경우가 거의 없다. 보통 사용자의 필요에 따라 여러 비동기 요청을 동시에 전송해서 데이터를 페이지에 미리 로드한다. 비동기는 다음 문제가 있다.

- 함수 간에 일시적 의존 관계가 형성 됨
- 콜백 피라미드의 늪에 빠짐
- 동기/비동기 코드의 호환되지 않는 조합

## 비동기 로직을 프라미스로 일급화

함수형을 이런 특징을 지녀야한다.

- 합성과 무인수 프로그래밍을 이용한다.
- 중첩된 구조를 선형적으로 흐르게 눌러 편다.
- 단일 함수로 에러 처리로직을 통합하여 코드 흐름을 원할하게한다.

위의 특징들은 모나드의 특징과도 같다. 비동기 로직을 가싸는 모나드인 프라미스를 소개한다.

프라미스의 상태는 보류, 이룸, 버림, 귀결 중 하나이다. 프라미스는 성공하면 resolve를 실패하면 reject를 콜백한다. 그 콜백이 .then과 .catch로 체이닝된다.

## 느긋한 데이터 생성

ES6의 강한 특성 중 하나는 어떤 함수를 끝까지 실행하지 않아도 데이터 제공을 잠시 중단한 상태로 다른 함수들과 더불어 작동시키는 능력이다. 거대한 자료구조를 당장 꼭 처리할 필요 없이 느긋하게 데이터를 생성하는 매개체로 함수를 활용할 수 있는 다양한 기회가 생기게 되는것이다.

`제너레이터`를 사용하는 것이다. 제너레이터는 `function*`로 선언할 수 있다. 그렇게 선언 된 제너레이터는 `yeild`를 통해 데이터를 순차적으로 뱉어낸다. 같은 ES6 신상인 `이터레이터`가 제너레이터로 구현되어 있다.

## RxJS

웹 앱에서 비동기 전략인 `AJAX`의 출현은 아주 큰 혁명을 가져왔다. 함수형 프로그래밍에서도 비동기 프로그램과 이벤트 기반 프로그램을 우아하게 엮는 RxJS에 대해 알아보자.

### 옵저버블 순차열로서의 데이터

옵저버블은 구독 가능한 모든 객체를 이야기한다. 애플리케이션은 파일 읽기, 웹서비스 호출, DB 쿼리 등등의 비동기 이벤트를 구독할 수 있다. 

```js
Rx.Observable.range(1, 3)
    .subscribe(
        x => console.log(`next: ${x}`),
        err => console.log(`error: ${err}`),
        () => console.log('done')
    )

    /*
    다음: 1
    다음: 2
    다음: 3
    완료
    */
```

리액티브 프로그래밍은 함수형과 유사한점이 많아 결국 `함수형 리액티브 프로그래밍`이라는 패러다임이 생겼다.

```js
Rx.Observable.fromEvent(document.querySelector('#student-ssn'), 'change')
    .map(x => x.target.value)
    .map(cleanInput)
    .map(checkLengthSsn)
    .subscribe(ssn => ssn.isRight ? console.log('Valid') : console.log('Invalid')); // Either모나드의 Right 이다.
```
### RxJS와 프라미스

```js
Rx.Observable.fromPromise(getJSON('/student'))
    .map(R.sortBy(R.compose(R.toLower, R.prop('firstname'))))
    .flatMapLatest(student => Rx.Observable.from(student))
    .filter(R.pathEq(['address', 'country'], 'US'))
    .subscribe(
        student => console.log(student.fullname),
        err => console.log(err)
    )
```

subscribe가 에러처리를 도맡는다.
