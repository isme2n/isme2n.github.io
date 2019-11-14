---
layout: post
title: "[모던자바스크립트] 26. this"
subtitle: "modern javascript, this"
categories: devlog
tags: javascript
comments:
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# this

객체는 일반적으로 실제 세계의 엔티티를 나타 내가 위해 만들어진다.

```js
let user = {
  name: "John",
  age: 30
};
```

현실에서는 사용자가 어떤 행동을 할 수 있다. 무언가를 장바구니에 넣는다던가, 로그인, 로그아웃을 한다 던가.

이런 액션들은 함수로 표현된다.

## 예시

`user`에게 인사하는법을 가르쳐보자.

```js
let user = {
  name: "John",
  age: 30
};

user.sayHi = function() {
  alert("Hello!");
};

user.sayHi(); // Hello!
```

여기서는 함수 표현식을 사용하여 함수를 만들고 `user.sayHi` 속성에 할당했다.

이제 호출하면 유저는 인사를 할 수 있다. 이런걸 `메소드`라고 한다.

### 객체 지향 프로그래밍

객체를 사용하여 엔티티를 나타내는 코드를 작성하는 방법을 `객체지향 프로그래밍(OOP)` 이라고 한다. 이 패러다임은 상당히 인기 있으며, 유용하기때문에 따로 또 공부하는것을 추천한다.

## this의 메소드

객체 메소드가 객체에 저장된 정보에 액세스하여 작업을 수행하는 것이 일반적이다.

예를들어, `user.sayHi()`는 `user`의 이름이 필요할 수 있다. 이 때 사용하는것이 `this` 키워드이다.

```js
let user = {
  name: "John",
  age: 30,

  sayHi() {
    // "this" 는 "현재 객체"
    alert(this.name);
  }
};

user.sayHi(); // John
```

## this는 바인딩되지 않는다

`this`는 런타임동안 평가된다.

예를들어, 여기서 동일한 함수가 두개의 다른 객체에 할당되고 `this`를 호출했다고 해보자.

```js
let user = { name: "John" };
let admin = { name: "Admin" };

function sayHi() {
  alert(this.name);
}

user.f = sayHi;
admin.f = sayHi;

user.f(); // John  (this == user)
admin.f(); // Admin  (this == admin)

admin["f"](); // Admin
```

### 객체없이 this를 호출하면 undefined

객체 없이 호출은 가능하지만, `undefined`가 나타난다. 이경우 `this.name`등은 오류가 발생한다.

엄격모드가 아닌경우에는 전역객체가 this가 되지만 좋지 않은 사용법이다.

## 화살표 함수에는 this가 없다.

화살표 함수는 자신의 `this`가 없다. 이경우 외부에서 가져오게 된다.

```js
let user = {
  firstName: "Ilya",
  sayHi() {
    let arrow = () => alert(this.firstName);
    arrow();
  }
};

user.sayHi(); // Ilya
```

화살표 함수는 유용하니 다음에 더 자세히 알아보자.

# 숙제

## 구문 검사

이 코드의 결과는 무엇인가?

```js
let user = {
  name: "John",
  go: function() {
    alert(this.name);
  }
}(user.go)();
```

함정이 있으니 조심!

## this?

아래 코드에서 `obj.go()`를 4번 연속으로 호출하려고한다.

근데.. 왜 다른값이 나오는걸까?

```js
let obj, method;

obj = {
  go: function() {
    alert(this);
  }
};

obj.go(); // (1) [object Object]

obj.go(); // (2) [object Object]

(method = obj.go)(); // (3) undefined

(obj.go || obj.stop)(); // (4) undefined
```

## 객체 리터럴에서 this 사용

여기서 함수 `makeUser`는 객체를 반환한다.

`ref`의 액세스 결과는 무엇일까?

```js
function makeUser() {
  return {
    name: "John",
    ref: this
  };
}

let user = makeUser();

alert(user.ref.name); // 결과가 뭐야?
```

## 계산기 만들기

`calculator`에 세가지 메소드를 만들자.

- `read()` 두 값을 입력하라는 메세지가 표시되고 객체 속성으로 저장한다.
- `sum()` 저장된 값의 합계를 반환한다.
- `mul()` 저장된 값을 곱하고 결과를 반환한다.

```js
let calculator = {
  // ...
};

calculator.read();
alert(calculator.sum());
alert(calculator.mul());
```

## 체인

위아래로 이동할 수 있는 `ladder`객체가 있다.

```js
let ladder = {
  step: 0,
  up() {
    this.step++;
  },
  down() {
    this.step--;
  },
  showStep: function() {
    // 현재 스텝 보여주기
    alert(this.step);
  }
};
```

순차적으로 호출하려면 아래처럼 할 수 있다.

```js
ladder.up();
ladder.up();
ladder.down();
ladder.showStep(); // 1
```

위 코드를 수정하여 체인이 가능하도록 만들어보자.

```js
ladder
  .up()
  .up()
  .down()
  .showStep(); // 1
```

이러한 방식은 자바스크립트 라이브러리에서 곧 잘 사용된다.
