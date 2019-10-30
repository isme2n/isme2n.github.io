---
layout: post
title: "[모던자바스크립트] 17. 훑어보기"
subtitle: "modern javascript, 훑어보기"
categories: devlog
tags: javascript
comments: true
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# 훑어보기

## 코드 구조

문장은 세미콜론으로 구분된다.

```
alert('Hello'); alert('World');
```

일반적으로 줄 바꿈도 구분 기호로 동작된다.

```
alert('Hello')
alert('World')
```

이는 명시적이지 않기 때문에 가끔 문제가 된다.

```
alert(“이 메세지 이후에 에러가 발생한다”)

[1, 2].forEach(alert)
```

## strict모드

최신 자바스크립트의 모든 기능을 활성화 하려면 `use strict`로 시작하면 된다.

## 변수

- let
- const (일정, 변경 불가)
- var (구식, 나중에 볼 것)

7가지 데이터 형이 있다.

- number: 부동 소수점과 정수 모두
- string: 문자열의 경우
- boolean: 논리 값의 경우 : true/false,
- null: "비어 있음"또는 "존재하지 않음"을 의미 하는 단일 값을 가진 유형
- undefined: "미 할당"을 의미 하는 단일 값을 가진 유형
- object와 symbol: 데이터 구조 및 고유 식별자 아직 배우지 않았다.

`typeof`는 두가지 예외를 제외하고는 자료형을 반환한다.

```
typeof null == "object" // 언어상의 에러
typeof function(){} == "function" // 함수는 특별히 다루어짐
```

## 상호작용

prompt(question, [default])

질문에 대한 대답이 필요할 때

confirm(question)

예 아니오의 선택이 필요 할 때

alert(message)

메세지 출력이 필요할 때

## 연산자

### 산술

`* + - /`, `%`, `**` 등이 있음

### 할당

`a*= 2`

### 삼항 연산자

`조건 ? 가 : 나`

### 논리 연산자

`&&`, `||`, `!`

### 비교

`==`, `===`

## 루프

세가지 루프를 배웠다

```
// 1
while (condition) {
  ...
}

// 2
do {
  ...
} while (condition);

// 3
for(let i = 0; i < 10; i++) {
  ...
}
```

## 스위치

```
let age = prompt('Your age?', 18);

switch (age) {
  case 18:
    alert("Won't work"); // the result of prompt is a string, not a number

  case "18":
    alert("This works!");
    break;

  default:
    alert("Any value not equal to one above");
}
```

## 함수

1. 함수선언

```
function sum(a, b) {
  let result = a + b;

  return result;
}
```

2. 함수 표현식

```
let sum = function(a, b) {
  let result = a + b;

  return result;
};
```

3. 화살표 함수

```
let sum = (a, b) => {
  // ...
  return a + b;
}
```
