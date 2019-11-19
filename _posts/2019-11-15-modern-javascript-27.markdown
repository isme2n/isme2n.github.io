---
layout: post
title: "[모던자바스크립트] 27. 객체를 원시형으로 변환"
subtitle: "modern javascript, 객체를 원시형으로 변환"
categories: devlog
tags: javascript
comments:
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# 객체를 원시형으로 변환

1. 모든 객체는 `true` 부울이다. 숫자나 문자열로 변환될 수 있다.
2. 숫자 변환은 객체를 빼거나 수학 함수를 적용할 때 발생한다. `Date` 객체를 뺄 수 있으며 그 결과는 두 날짜 사이의 시간 차이다.
3. 문자열 변환은 일반적으로 `alert(obj)`와 비슷하다.

## 기본

특수한 객체 메소드를 사용하여 문자열 및 숫자 변환을 조정할 수 있다.

### string

객체를 문자열로 변환하는 경우

```js
// alert의 결과는 문자열로 변환된다.
alert(obj);

// 속성키로 사용할때 문자열로 변환된다.
anotherObj[obj] = 123;
```

### number

수학 계산을 할떄

```js
// 명시적으로 변환
let num = Number(obj);

// 수학 계산 (바이너리 덧셈은 제외)
let n = +obj; // 단항 덧셈
let delta = date1 - date2;

// 작은/큰 비교
let greater = user1 > user2;
```

### default

오퍼레이터가 어떤 유형을 기대해야하는지 확실하지 않은 경우에 발생한다.

예를 들어, 이진 덧셈은 문자열과 숫자가 작동할 수 있으므로 문자열과 숫자가 모두 작동한다. 따라서 이진 덧셈에서 객체를 인수로 가져오면 `default`힌트를 사용하여 객체를 변환한다.

또한 문자열, 숫자 또는 심볼을 `==`을 사용하여 객체를 비교하면 어떤 변환을 수행해야 할지 확실하지 않으므로 `default`힌트가 사용된다.

```js
// "default" 힌트가 이용된 이진 덧셈
let total = obj1 + obj2;

// "default" 힌트가 이용된 obj == number
if (user == 1) { ... };
```

` <``> ` 비교 연산자는 문자열과 숫자 모두 작동한다. 그럼에도 불구하고 그들은 `default` 힌트가 아닌 `number`를 사용한다.

#### 변환을 수행하기 위해 자바스크립트는 세가지 객체 메소드를 찾아 호출한다.

1. `obj[Symbol.toPrimitive](hint)` - 시스템 심볼이 있는 메소드인경우
2. `string` 힌트인경우
   - `obj.toString()`를 시도하고 `obj.valueOf()`를 시도하면 무엇이든 존재한다.
3. 그렇지 않으면 힌트가 `number` 또는 `default`
   - `obj.valueOf()`를 시도하고 `obj.toString()`를 시도하면 무엇이든 존재한다.

## Symbol.toPrimitive

첫번째 방법부터 시작해보자. `Symbol.toPrimitive`와 같이 변환 방법의 이름을 지정하는데 사용되는 기본 제공 심볼이 있다.

```js
obj[Symbol.toPrimitive] = function(hint) {
  // 원시형을 반드시 리턴한다.
  // hint = "string", "number", "default" 중에 하나이다.
};
```

```js
let user = {
  name: "John",
  money: 1000,

  [Symbol.toPrimitive](hint) {
    alert(`hint: ${hint}`);
    return hint == "string" ? `{name: "${this.name}"}` : this.money;
  }
};

// 변환 예:
alert(user); // hint: string -> {name: "John"}
alert(+user); // hint: number -> 1000
alert(user + 500); // hint: default -> 1500
```

## toString / valueOf

`toString`과 `valueOf`는 고대로부터 왔다. 심볼이 존재하기 전부터 사용되던 방법이다.

`Symbol.toPrimitive`가 없으면 자바스크립트가 이를 찾아 순서대로 시도한다.

- `toString -> valueOf` 문자열 힌트 인 경우
- `valueOf -> toString` 그렇지 않은 경우

이 메소드는 기본 값을 리턴해야한다. 만약 객체를 반환하면 무시된다.

기본적으로 평범한 객체의 `toString`과 `valueOf`는 아래처럼 작동한다.

- `toString`메소드는 문자열을 반환한다. `[object Object]`
- `valueOf`메소드는 객체 자체를 반환한다.

```js
let user = { name: "John" };

alert(user); // [object Object]
alert(user.valueOf() === user); // true
```

따라서 객체를 문자열처럼 사용하려고하면 `alert`기본적으로 `[object Object]`가 된다.

`Symbol.toPrimitive`대신 `toString`하고 `valueOf`로 구현해보자.

```js
let user = {
  name: "John",
  money: 1000,

  // hint="string"
  toString() {
    return `{name: "${this.name}"}`;
  },

  // hint="number" 또는 "default"
  valueOf() {
    return this.money;
  }
};

alert(user); // toString -> {name: "John"}
alert(+user); // valueOf -> 1000
alert(user + 500); // valueOf -> 1500
```

종종 모든 기본형변환을 처리 할 수 있는 단일 방법이 필요할떄가 있다. 이 경우 `toString`으로 구현할 수 있다.

```js
let user = {
  name: "John",

  toString() {
    return this.name;
  }
};

alert(user); // toString -> John
alert(user + 500); // toString -> John500
```

`Symbol.toPrimitive`와 `valueOf`의 부재시, `toString`이 모든 원시 변환을 처리한다.

## 더 나아가서

우리가 이미 알고 있듯이 많은 연산자와 함수는 타입변환을 수행한다. 예를들어 곱셈은 피연산자를 숫자로 변환한다.

객체를 인수로 전달하면 두 단계가 있다.

1. 객체는 위에서 설명한 규칙을 사용하여 프리미티브로 변환된다.
2. 결과 프리미티브가 올바른 타입이 아닌경우 변환된다.

```js
let obj = {
  toString() {
    return "2";
  }
};

alert(obj * 2); // 4, "2"로 나오지만, 곱셈이 2로 변환한다.
```
