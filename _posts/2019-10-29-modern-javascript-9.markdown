---
layout: post
title: "[모던자바스크립트] 9. 비교"
subtitle: "modern javascript, 비교"
categories: devlog
tags: javascript
comments: true
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# 비교

- 보다 큼, 작음 : a > b, a < b
- 크거나 작음 : a >= b, a <= b
- 같음 : a == b
- 같지 않음: a != b

연산의 결과는 부울값으로 나온다.

```
alert( 2 > 1 );  // true
alert( 2 == 1 ); // false
alert( 2 != 1 ); // true
```

## 문자열 비교

문자열 비교하는 알고리즘은 간단하다.

1. 첫 문자부터 순서대로 비교한다.
2. 유니코드를 비교해서 더 큰 값이 크다.
3. 길이가 길다면 더 크다.

```
alert( 'Z' > 'A' ); // true
alert( 'Glow' > 'Glee' ); // true
alert( 'Bee' > 'Be' ); // true
```

## 다른 타입 비교

자바스크립트는 비교할때 숫자로 변경하여 비교한다.

```
alert( '2' > 1 ); // true
alert( '01' == 1 ); // true
alert( true == 1 ); // true
alert( false == 0 ); // true
```

## 엄격 동등

동등 비교에는 몇가지 문제가 있다.

```
alert( 0 == false ); // true
alert( '' == false ); // true
```

그래서 주로 엄격동등을 사용한다. 엄격동등비교는 타입 변환을 하지 않고 비교한다.

```
alert( 0 === false ); // false
```

## null, undefined 비교

```
alert( null === undefined ); // false
alert( null == undefined ); // true
```

# 숙제

## 비교

아래 결과는?

```
5 > 4
"apple" > "pineapple"
"2" > "12"
undefined == null
undefined === null
null == "\n0\n"
null === +"\n0\n"
```
