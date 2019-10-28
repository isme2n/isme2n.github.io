---
layout: post
title: "[모던자바스크립트] 7. 타입변환"
subtitle: "modern javascript, 타입변환"
categories: devlog
tags: javascript
comments: true
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# 타입 변환

대부분의 경우 자바스크립트는 주어진 값을 올바른 유형으로 자동 변환한다.

예를 들면 `alert`는 자동으로 모든 값을 문자열로 변환하여 표시한다. 수학 연산이라면 숫자로 변환한다.

하지만 값을 명시적으로 예상 자료형으로 변환해야 하는 경우도 있다.

## 문자열 변환

`String()`을 사용하여 명시적으로 변환가능하다.

```
let value = true;
alert(typeof value); // boolean

value = String(value); // value 는 이제 "true"
alert(typeof value); // string
```

## 숫자 변환

보통 연산자가 있다면 자동으로 변환된다.

```
alert( "6" / "2" ); // 3
```

`Number()`를 사용하여 명시적으로 변환가능하다.

```
let str = "123";
alert(typeof str); // string

let num = Number(str); // str은 이제 123

alert(typeof num); // number
```

숫자가 아닌 값을 넣으면 `NaN`이 반환된다.

```
let age = Number("an arbitrary string instead of a number");

alert(age); // NaN
```

- undefined: NaN
- null: 0
- true, false: 1, 0

`+` 더하기는 어느 하나가 문자열이라면 문자열 결합연산을 한다.

```
alert( 1 + '2' ); // '12'
```

## 부울 변환

- falsy 값(0, null, undefined, NaN, false 등)들은 모두 `false`로 변환된다.
- 다른값들은 `true`

```
alert( Boolean(1) ); // true
alert( Boolean(0) ); // false

alert( Boolean("hello") ); // true
alert( Boolean("") ); // false

alert( Boolean("0") ); // true
alert( Boolean(" ") ); //  true
```

# 숙제

다음 표현의 결과는?

```
"" + 1 + 0
"" - 1 + 0
true + false
6 / "3"
"2" * "3"
4 + 5 + "px"
"$" + 4 + 5
"4" - 2
"4px" - 2
7 / 0
"  -9  " + 5
"  -9  " - 5
null + 1
undefined + 1
" \t \n" - 2
```
