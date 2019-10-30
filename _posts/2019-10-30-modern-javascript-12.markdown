---
layout: post
title: "[모던자바스크립트] 12. 논리 연산자"
subtitle: "modern javascript, 논리 연산자"
categories: devlog
tags: javascript
comments: true
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# 논리 연산자

자바스크립트는 세가지의 논리 연산자를 가지고 있다.

## || 또는

OR 연산자는 `||` 이렇게 나타낸다.

```
result = a || b;
```

인수 중 하나라도 true라면 true를 반환한다.

```
alert( true || true );   // true
alert( false || true );  // true
alert( true || false );  // true
alert( false || false ); // false
```

더 많은 조건을 검사할 수도 있다.

```
let hour = 12;
let isWeekend = true;

if (hour < 10 || hour > 18 || isWeekend) {
  alert( 'The office is closed.' ); // it is the weekend
}
```

## 첫 번째 true 값 찾기

`||`의 자주 쓰이는 쓰임새로는 첫 번째 트루값을 찾는 것이다.

여러개의 인자가 주어지면 왼쪽부터 하나씩 트루값을 검증하는데, 이는 OR의 논리연산 특성상 true가 하나만 있어도 true를 반환하면 되기 때문이다. 이런특성을 이용하여 첫번째 트루값을 찾을 수 있다.

```
alert( 1 || 0 ); // 1
alert( true || 'no matter what' ); // true

alert( null || 1 ); // 1
alert( null || 0 || 1 ); // 1
alert( undefined || null || 0 ); // 0 (모두 falsy, 마지막 값을 반환한다)
```

재밌고 유용한 쓰임새의 예를 몇가지 보자.

1. 변수 또는 표현식 목록에서 첫 번째 truthy 값 얻기

`null/undefined`가 포함된 값들의 목록중에 데이터가 있는 첫 번째 값을 찾으려면 어떻게 해야할까?

```
let currentUser = null;
let defaultUser = "John";

let name = currentUser || defaultUser || "unnamed";

alert( name ); // “John”
```

2. 단락 평가

```
let x;

true || (x = 1);

alert(x); // undefined
```

```
let x;

false || (x = 1);

alert(x); // 1
```

단락평가는 사실 if로 대신할 수 있다. 그럼에도 가끔 사용될 때가 있다.

## && 그리고

피연산자가 모두 true 값을 때만 true를 반환한다.

```
alert( true && true );   // true
alert( false && true );  // false
alert( true && false );  // false
alert( false && false ); // false
```

```
let hour = 12;
let minute = 30;

if (hour == 12 && minute == 30) {
  alert( 'The time is 12:30' );
}
```

## &&는 첫번째 falsy 값을 찾는다.

```
alert( 1 && 0 ); // 0
alert( 1 && 5 ); // 5

alert( null && 5 ); // null
alert( 0 && "no matter what" ); // 0

alert( 1 && 2 && null && 3 ); // null
alert( 1 && 2 && 3 ); // 3
```

AND 도 OR 처럼 if 문 대신 사용될 수 있다.

```
let x = 1;

(x > 0) && alert( 'Greater than zero!' );
```

## ! 부정

부정할 때 사용된다.

```
result = !value;
```

1. 피연산자를 부울값으로 변환하고.
2. 역값을 반환한다.

```
alert( !true ); // false
alert( !0 ); // true
```

또는 `!!` 부정을 두번하여 현재값을 부울형으로 바꿀 수 있다.

```
alert( !!"non-empty string" ); // true
alert( !!null ); // false
```

이는 불리언함수와 같은 역할을 한다.

```
alert( Boolean("non-empty string") ); // true
alert( Boolean(null) ); // false
```

# 숙제

## OR의 결과는?

```
alert( null || 2 || undefined );
```

## OR의 결과는? 2

```
alert( alert(1) || 2 || alert(3) );
```

## AND의 결과는?

```
alert( 1 && null && 2 );
```

## AND의 결과는? 2

```
alert( alert(1) && alert(2) );
```

## 복잡한 논리 연산의 결과는?

```
alert( null || 2 && 3 || 4 );
```

## 코드를 작성하자

“If”문을 작성하여 age가 14와 90 사이에 포함되어 있는지 확인해보자.

포함은 14와 90이 될 수 있음을 의미한다.

## 코드를 작성하자 2

age가 14와 90 사이의 값이 아닌 “if”문을 작성하라.

!을 사용하여 &&로 하는 방식과 부정을 사용하지 않는 방식 둘다 작성해보자.

## if

어느 것이 실행이되고 “if”문의 결과는 무엇일까?

```
if (-1 || 0) alert( 'first' );
if (-1 && 0) alert( 'second' );
if (null || -1 && 1) alert( 'third' );
```

## 로그인확인

prompt로 로그인을 요청하는 코드를 작성해보자.

1. UserName을 받는다.
2. UserName이 “Admin”이면 Password를 받는다.
3. UserName이 빈값이거나 falsy 값이면 “Canceled”를 보여준다.
4. 그 외의 경우에는 “I don’t know you”를 보여준다.
5. Password가 “TheMaster”이면 ‘Welcome”을 보여준다.
6. Password가 빈값이거나 falsy 값이면 “Canceled”를 보여준다.
7. 그 외의 경우에는 “Wrong Password”를 보여준다.
