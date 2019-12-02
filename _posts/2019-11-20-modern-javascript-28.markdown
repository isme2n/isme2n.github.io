---
layout: post
title: '[모던자바스크립트] 28. 생성자 new'
subtitle: 'modern javascript, 생성자 new'
categories: devlog
tags: javascript
comments:
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# 생성자 new

생성자 함수는 일반 함수이지만 그래도 일반적인 두가지 규칙이 있다.

1. 대문자로 시작한다.
2. `new`연산자로만 실행한다.

```js
function User(name) {
  this.name = name;
  this.isAdmin = false;
}

let user = new User('Jack');

alert(user.name); // Jack
alert(user.isAdmin); // false
```

`new`는 다음 단계를 수행한다.

1. 새로운 빈 객체가 `this`에 할당된다.
2. 함수 본문이 실행된다. 일반적으로 `this`를 수정하고 새 속성을 추가한다.
3. `this`의 값이 반환된다.

```js
function User(name) {
  // this = {};  (묵시적)

  // 속성 추가
  this.name = name;
  this.isAdmin = false;

  // return this;  (묵시적)
}
```

## 생성자 테스트 : new.target

`new` 함수 내에서 `new.target` 속성을 사용하여 함수가 호출되었는지 여부를 확인할 수 있다.

일반적인 호출의 경우 비어있다.

```js
function User() {
  alert(new.target);
}

// without "new":
User(); // undefined

// with "new":
new User(); // function User { ... }
```

즉, 함수내부에서 `생성자 모드`로 호출되었는지 `일반모드`로 호출되었는지 알 수 있다.

어떤 상황에서건 동일한 작업을 하기위해 호출시킬 수도 있다.

```js
function User(name) {
  if (!new.target) {
    // new 없이 호출하면
    return new User(name); // new 해줄게
  }

  this.name = name;
}

let john = User('John');
alert(john.name); // John
```

이런 방식은 보통 쉬운사용을 위해 라이브러리에서 설탕으로 사용한다. 그로인해 `new`없이 호출 할 수 있다.

물론 명시적으로 붙이는게 좋다.

## 생성자에서 return

일반적으로 생성자는 `return`이 없다. 그들의 임무는 `this`에 필요한 모든것을 작성하는 것일 뿐이다.

그러나 `return`이 있으면 다음과 같다.

- 객체를 `return`하면 `this`대신 반환된다.
- 원시형이 반환되면 무시된다.

```js
function BigUser() {
  this.name = 'John';

  return { name: 'Godzilla' }; // <-- 이 객체를 반환
}

alert(new BigUser().name); // Godzilla
```

### 인수가 없는 경우 괄호를 생략할 수 있다.

```js
let user = new User(); // <-- 괄호생략
// 같다.
let user = new User();
```

## 생성자의 메소드

생성자 함수를 사용하여 객체를 생성하면 유연성이 향상된다. 생성자 함수에는 개체를 구성하는 방법과 넣을 방법을 정의하는 매개 변수가 있을 수 있다.

```js
function User(name) {
  this.name = name;

  this.sayHi = function() {
    alert('My name is: ' + this.name);
  };
}

let john = new User('John');

john.sayHi(); // My name is: John

/*
john = {
   name: "John",
   sayHi: function() { ... }
}
*/
```

## 개요

- 생성자는 일반 함수이지만 대문자로 시작하는 관행이있다.
- 생성자는 `new`를 사용하여 호출한다.

# 숙제

## `new A()==new B()` 인 A와 B를 만들 수 있을까?

```js
function A() { ... }
function B() { ... }

let a = new A;
let b = new B;

alert( a == b ); // true
```

가능하다면 코드를 적어보자.

## 계산기 만들기

3가지 기능이 있는 생성자를 작성해보자.

- `read()`: `prompt`를 사용하여 두 값을 요청하고 기억함.
- `sum()`: 속성의 합계를 반환
- `mul()`: 속성의 곱을 반환

```js
let calculator = new Calculator();
calculator.read();

alert('Sum=' + calculator.sum());
alert('Mul=' + calculator.mul());
```

## 누산기 만들기

`Accumulator(startingValue)` 생성자를 만든다.

- 생성시 시작값을 `value`에 저장한다.
- `read()`: `prompt`로 얻은 값을 `value`에 추가한다.

```js
let accumulator = new Accumulator(1); // 초기값 1

accumulator.read(); // 입력값을 더한다.
accumulator.read(); // 입력값을 더한다.

alert(accumulator.value); // 값을 출력한다.
```
