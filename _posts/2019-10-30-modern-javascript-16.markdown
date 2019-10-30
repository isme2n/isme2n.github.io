---
layout: post
title: "[모던자바스크립트] 16. 함수 표현식"
subtitle: "modern javascript, 함수표현식"
categories: devlog
tags: javascript
comments: true
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# 함수표현식과 화살표 함수

함수 선언과 사용에 대해 배웠다.

```
function sayHi() {
  alert( "Hello" );
}
```

이를 함수 선언이라고 한다. 함수를 작성하는 또 다른 방법이 있다.

```
const sayHi = function() {
  alert( "Hello" );
};
```

여기서 함수는 다른 값과 마찬가지로 명시적으로 변수에 작성되고 지정된다. 이 표현식의 의미는 단순히 함수를 만들어 변수에 넣는것이다.

## 콜백함수

함수를 값으로 전달하는 예를 살펴보자.

`ask(question, yes, no)`를 작정해보자.

- Question: 질문의 텍스트
- Yes: 예을 경우 실행할 함수
- No: 아닌경우 실행할 함수

```
function ask(question, yes, no) {
  if (confirm(question)) yes()
  else no();
}

function showOk() {
  alert( "You agreed." );
}

function showCancel() {
  alert( "You canceled the execution." );
}

ask("Do you agree?", showOk, showCancel);
```

## 함수 표현과 함수 선언

1. 함수표현식은 실행이 도달 할 때 만들어지며 그 순간부터만 사용할 수 있다.
2. 함수 선언은 정의된 것보다 먼저 사용가능하다.

함수 선언은 전역으로 인식되어 사용할 수 있다.

```
sayHi("John"); // Hello, John

function sayHi(name) {
  alert( `Hello, ${name}` );
}
```

하지만 최신자바스크립트에서 함수가 선언된 블록의 외부에서는 참조할 수 없다.

```
let age = prompt("What is your age?", 18);

// conditionally declare a function
if (age < 18) {

  function welcome() {
    alert("Hello!");
  }

} else {

  function welcome() {
    alert("Greetings!");
  }

}

// ...use it later
welcome(); // Error: welcome is not defined
```

이 경우에는 변수를 만들어 함수표현식으로 할당한다면 사용할 수 있다.

```
let age = prompt("What is your age?", 18);

let welcome;

if (age < 18) {

  welcome = function() {
    alert("Hello!");
  };

} else {

  welcome = function() {
    alert("Greetings!");
  };

}

welcome(); // ok
```

일반적으로 함수선언을 사용하면 어디서든 사용할 수 있기때문에 선언을 먼저 고려하고, 위 처럼 스코프 문제가 생기는 등의 경우 함수 표현식을 사용하곤한다.

## 화살표 함수

함수를 생성하기 위해 간단한 구문이 하나 더있다.

```
let func = (arg1, arg2, ...argN) => expression
```

예를 보면

```
let sum = (a, b) => a + b;

/* 이것의 함축버전이다:

let sum = function(a, b) {
  return a + b;
};
*/

alert( sum(1, 2) ); // 3
```

이전의 식을 간단히 줄이면 이렇게 된다.

```
let age = prompt("What is your age?", 18);

let welcome = (age < 18) ?
  () => alert('Hello') :
  () => alert("Greetings!");

welcome();
```

화살표함수에는 더 재미있는 기능들이 있지만, 그건 추후에 다루도록 하자.

# 숙제

## 화살표함수로 다시 작성하기

코드를 화살표함수를 사용하여 다시 작성해보자.

```
function ask(question, yes, no) {
  if (confirm(question)) yes()
  else no();
}

ask(
  "Do you agree?",
  function() { alert("You agreed."); },
  function() { alert("You canceled the execution."); }
);
```
