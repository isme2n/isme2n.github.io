---
layout: post
title: "[모던자바스크립트] 6. 자료형"
subtitle: "modern javascript, 자료형"
categories: devlog
tags: javascript
comments: true
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# 자료형

자바스크립트의 변수는 모든 데이터를 포함 할 수 있다. 변수는 어떤 순간에는 문자열이 될 수 있고 어떤 순간에는 숫자가 될 수 있다.

```
let message = "hello";
message = 123456;
```

이러한 것을 허용하는 것을 `동적 유형`이라고 한다. 즉, 자료형이 존재하지만 변수는 자료형에 바인딩 되어 있지 않다.

자바스크립트에는 7가지 기본 데이터 유형이 있다.

- Number
- String
- Bool
- Null
- Undefined
- Object
- Symbol


## Number

```
let n = 123;
n = 12.345;
```
넘버는 정수 및 부동 소수점 숫자를 모두 나타낼 수 있다.

일반적인 숫자 이외에도, `Infinity`, `-Infinity`, `NaN`도 포함된다.

### Infinity

`Infinity`는 무한대를 이야기한다. 임의의 숫자보다 큰 특수 값이다. 
0으로 나누거나 직접 타이핑하여 사용할 수 있다 
```
alert( 1 / 0 ); // Infinity alert( Infinity ); // Infinity ```

### NaN

`NaN`은 ‘Not a Number’로써 계산 오류를 나타낸다. 연산이 잘못되었거나 정의되지 않은 결과이다.

연산의 한쪽이 `NaN`이라면 그 연산은 줄곧 `NaN`이다.

```
alert( "not a number" / 2 ); // NaN
alert( "not a number" / 2 + 5 ); // NaN
```

자바스크립트의 수학 연산은 에러를 뿜어내지 않는다. 문자를 숫자로 나누거나 하는 최악의 상황에도 에러가 나오는게 아니라 `NaN`이 반환된다.

## String

자바스크립트에서 문자열은 따옴표로 묶어야한다.

```
let str = "Hello";
let str2 = 'Single quotes are ok too';
let phrase = `can embed ${str}`;
```

자바스크립트에는 3 가지 유형의 따옴표가 있다.

1. 큰 따옴표 : "Hello".
2. 작은 따옴표 : 'Hello'.
3. 백틱(역 따옴표) : `Hello`.

큰 따옴표와 작은 따옴표는 자바스크립트에서 차이가 없다. 

백틱은 변수와 표현식을 `${…}`에 묶어 문자열에 포함시킬 수 있다.

```
let name = "John";

// 변수 포함 시키기
alert( `Hello, ${name}!` ); // Hello, John!

// 표현식
alert( `the result is ${1 + 2}` ); // the result is 3
```

## Bool

불 유형은 논리형이라고도 한다. 값은 오직 두가지. `true`, `false`

이 자료형은 일반적으로 예/아니오 값을 저장하는데 사용된다.

```
let isGreater = 4 > 1;

alert( isGreater ); // true
```

## Null

자바스크립트는 null값을 저장하는데 null이라는 자료형을 사용한다. 다른 언어처럼 ‘존재하지 않는 객체에 대한 참조’나 ‘널포인터’가 아니다.

아무것도 없는 값을 나타내는 특수한 값이다.


## Undefined

Undefined 또한 자신만의 유형을 만든다. 값이 할당되지 않았다는 의미로 사용된다.

```
let x;

alert(x); // "undefined"
```

직접 대입도 가능하다.

```
let x = 123;

x = undefined;

alert(x); // "undefined"
```

하지만 이렇게 사용하는 건 바람직하지 않다. 정말로 할당이되지 않았는지를 확인할 때 사용하는 것이 좋다. null값과 함께 변수가 할당되었는지, 비었는지를 확인할 때 유용하게 사용할 수 있다.

## Object

다른 자료형과는 다르게 객체 자료형은 여러 데이터의 모음이라고 할 수 있다. 다른 자료형들은 단일 값만을 가질 수 있는 반면에 객체형은 더 복잡한 엔티티를 표현할 수 있다.

## Symbol

심볼 자료형은 객체의 고유 식별자를 만드는데 사용한다. 이 자료형에 대해서는 추후에 더 알아보자.

# typeof

`typeof`는 인수의 자료형을 반환한다. 두가지 방법으로 사용될 수 있다.

1. typeof x
2. typeof(x)

```
typeof undefined // "undefined"

typeof 0 // "number"

typeof true // "boolean"

typeof "foo" // "string"

typeof Symbol("id") // "symbol"

typeof Math // "object" 

typeof null // "object"  (1)

typeof alert // "function"  (2)
```

1. null 은 null 형이라고 했는데 왜 객체형이지? 이건 언어상의 오류이다. 너무 신경쓰지 말자
2. function형은 없었는데요? function은 객체형의 일종이다.

# 숙제

다음 스크립트의 출력은?

```
let name = "Ilya";

alert( `hello ${1}` ); // ?

alert( `hello ${"name"}` ); // ?

alert( `hello ${name}` ); // ?
```
