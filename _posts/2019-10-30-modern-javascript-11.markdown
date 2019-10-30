---
layout: post
title: "[모던자바스크립트] 11. 조건 연산자"
subtitle: "modern javascript, 조건 연산자"
categories: devlog
tags: javascript
comments: true
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# 조건 연산자 if, ?

조건에 따라 다른 행동을 수행해야 하는 경우가 종종 있다.

## if

`if(…)` 문의 경우 괄호안의 상태를 확인하고 상태가 `true`면 코드 블록을 실행한다.

```
let year = prompt('In which year was ECMAScript-2015 specification published?', '');

if (year == 2015) {
  alert( "That's correct!" );
  alert( "You're so smart!" );
}
```

- 숫자 0, 빈 문자열 "", null, undefined, 그리고 NaN. 모두가 false. 이를 `falsy`값이라 한다.
- 다른 값은 true로 "truthy"라고한다.

## else

If 와 짝을 이루는 `else`가 있다. if절의 조건이 거짓일경우 실행된다.

```
let year = prompt('In which year was the ECMAScript-2015 specification published?', '');

if (year == 2015) {
  alert( 'You guessed it right!' );
} else {
  alert( 'How can you be so wrong?' ); // 2015가 아닌 다른 값이라면
}
```

## else if

여러조건을 검사하고 싶다면 else if 절을 사용하면 된다.

```
let year = prompt('In which year was the ECMAScript-2015 specification published?', '');

if (year < 2015) {
  alert( 'Too early...' );
} else if (year > 2015) {
  alert( 'Too late' );
} else {
  alert( 'Exactly!' );
}
```

## 삼항연산자 ?

삼항연산자는 항이 3개이기때문에 삼항연산자라고 불린다.

```
let result = condition ? value1 : value2;
```

condition이 true 면 value1이 false면 value2가 result에 할당된다.

## 여러개의 ?

```
let age = prompt('age?', 18);

let message = (age < 3) ? 'Hi, baby!' :
  (age < 18) ? 'Hello!' :
  (age < 100) ? 'Greetings!' :
  'What an unusual age!';

alert( message );
```

이런식의 사용도 가능하다. 이는 다음과 같은 코드다.

```
if (age < 3) {
  message = 'Hi, baby!';
} else if (age < 18) {
  message = 'Hello!';
} else if (age < 100) {
  message = 'Greetings!';
} else {
  message = 'What an unusual age!';
}
```

삼항연산자를 무분별하게 사용하는건 코드의 가독성을 낮추니 잘 사용하도록하자.

# 숙제

## if의 조건

`alert`는 표시될까?

```
if ("0") {
  alert( 'Hello' );
}
```

## 자바스크립트의 이름은?

if..else구문을 사용하여 'JavaScript의 "공식"이름은 무엇입니까? "라는 코드를 작성해보자.
방문자가 "ECMAScript"를 입력하면 "Right!"를 출력하고 그렇지 않으면 “자바스크립트의 공식이름은 ECMAScript에요!” 라고 출력하자.

## 표시

prompt를 사용하여 숫자를 얻고 if..else로 다음과 같이 alert로 출력하라.

- 1값이 0보다 크면
- -10보다 작은 경우
- 0이면 0입니다.

모든 입력은 숫자라고 가정한다.

## ? 로 변환

?를 사용하여 작성하라.

```
let result;

if (a + b < 4) {
  result = 'Below';
} else {
  result = 'Over';
}
```

## ?로 변환 2

```
let message;

if (login == 'Employee') {
  message = 'Hello';
} else if (login == 'Director') {
  message = 'Greetings';
} else if (login == '') {
  message = 'No login';
} else {
  message = '';
}
```
