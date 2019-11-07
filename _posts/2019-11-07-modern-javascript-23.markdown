---
layout: post
title: "[모던자바스크립트] 23. 오브젝트"
subtitle: "modern javascript, 오브젝트"
categories: devlog
tags: javascript
comments: true
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# 객체 (오브젝트)

자바스크립트에는 7가지 데이터 형식이 있다. 그 중 6개는 값에 단일 항목만 포함되기 때문에 `원시타입`이라고 한다.

반면, 객체는 다양한 데이터 또는 더 복잡한 엔티티의 키순 모음을 저장하는 데 사용된다. 자바스크립트에서 객체는 언어의 거의 모든 측면을 관통한다. 따라서 우리는 다른 곳으로 깊이 들어가기 전에 먼저 이해해야한다.

중괄호를 사용하여 객체를 만들 수 있다. `key: value`쌍으로 `key`는 문자열, `value`는 무엇이든 가능하다.

객체는 두 구문 중 하나를 사용하여 빈 객체를 만들 수 있다.

```js
let user = new Object(); // "object constructor" 구문
let user = {}; // "object literal" 구문
```

일반적으로 리터럴 방식이 사용된다.

## 리터럴 및 속성

생성시 키밸류를 쌍으로 넣을 수 있다.

```js
let user = {
  // 객체
  name: "John", // "John" 값을 "name" 키에 담음
  age: 30 // 30 값을 "age" 키에 담음
};

// 이렇게 꺼내올 수 있다.
alert(user.name); // John
alert(user.age); // 30
```

값은 모든 유형이 될 수 있다.

```js
user.isAdmin = true;
```

속성을 제거하려면 `delete`를 사용할 수 있다.

```js
delete user.age;
```

여러단어로 된 속성을 사용할 수 있지만 따옴표로 감싸져야한다.

```js
let user = {
  "likes birds": true
};
```

마지막 속성도 쉼표로 끝날 수 있다. 이로인해 모든 줄이 똑같기 때문에 쉽게 추가, 제거 할 수 있다.

```js
let user = {
  name: "John",
  age: 30
};
```

## 대괄호

여러 단어로 된 속성같은 경우는 도트 접근이 작동하지 않는다.

```js
// error
user.likes birds = true
```

`대괄호 표기법`을 사용하여 해결할 수 있다.

```js
let user = {};

// set
user["likes birds"] = true;

// get
alert(user["likes birds"]); // true

// delete
delete user["likes birds"];
```

키를 변수로 사용할 수도 있다.

```js
let user = {
  name: "John",
  age: 30
};

let key = prompt("What do you want to know about the user?", "name");

// 변수로 접근
alert(user[key]); // John ("name"을 입력했다면)
```

## 계산된 속성

객체 리터럴에 대괄호를 사용할 수 있다. 이를 `계산된 속성`이라고 한다.

```js
let fruit = prompt("Which fruit to buy?", "apple");

let bag = {
  [fruit]: 5 // fruit 으로 받은 값
};

alert(bag.apple); // 5, fruit="apple" 이면
```

위 코드는 아래 코드와 같이 동작한다.

```js
let fruit = prompt("Which fruit to buy?", "apple");
let bag = {};

bag[fruit] = 5;
```

대괄호는 활용성이 높지만 도트 표기법에 비해 사용하기 번거롭다. 그리고 오타가 날 가능성도 높다. 일상적으로 도트 접근을 사용하지만 더 복잡한것이 요구된다면 대괄호로 바꾸면 된다.

### 속성 이름은 예약어가 사용가능하다

변수는 `for, let, return`과 같은 예약어를 가질 수 없지만 객체는 속성으로 가질 수 있다.

```js
let obj = {
  for: 1,
  let: 2,
  return: 3
};

alert(obj.for + obj.let + obj.return); // 6
```

기본적으로 모든 이름이 허용되지만 `__proto__`의 경우 객체가 아닌 값으로 설정할 수 없다.

```js
let obj = {};
obj.__proto__ = 5;
alert(obj.__proto__); // [object Object], 의도대로 동작하지 않음.
```

5의 할당은 무시 되었다.

## 약식 속성값

실제 코드에서는 기존 변수를 속성 이름의 값으로 사용하는 경우가 더러있다.

```js
function makeUser(name, age) {
  return {
    name: name, // 이런식으로
    age: age // 이런식으로
    // ...다른 속성들
  };
}

let user = makeUser("John", 30);
alert(user.name); // John
```

이를 더 짧게 만들 수 있는데, 아래와 같이 하면 된다.

```js
function makeUser(name, age) {
  return {
    name, // name: name 이랑 똑같음
    age // age: age 이랑 똑같음
    // ...
  };
}
```

## 유무 확인

존재하지 않는 속성을 접근하려 하면 `undefined`를 반환한다.

```js
let user = {};

alert(user.noSuchProperty === undefined); // true
```

`in`을 사용하여 확인 할 수도있다.

```js
let user = { name: "John", age: 30 };

alert("age" in user); // true
alert("blabla" in user); // false
```

## for...in 루프

객체의 모든 키를 살펴보려면 루프를 돌릴 수 있다. 우리가 이미 알고 있던 `for`와는 사용법이 조금 다르다.

```js
for (key in object) {
  // 객체의 각 속성을 돌아다니며 이 바디를 실행한다.
}
```

모든 속성을 출력하는 예제를 봐보자.

```js
let user = {
  name: "John",
  age: 30,
  isAdmin: true
};

for (let key in user) {
  // keys
  alert(key); // name, age, isAdmin
  // values
  alert(user[key]); // John, 30, true
}
```

물론 `key`가 아닌 다른 변수를 사용해도 된다. `for (let prop in obj)`

## 객체의 순서화

객체를 반복하면 순서가 동일하게 가져오는가? 객체는 어떻게 순서화되는가? 대답은 `특별한 방식으로 정렬 된다.`

정수 속성이 정렬되고 다른 속성은 생성 순서로 나타난다.

```js
let codes = {
  "49": "Germany",
  "41": "Switzerland",
  "44": "Great Britain",
  // ..,
  "1": "USA"
};

for (let code in codes) {
  alert(code); // 1, 41, 44, 49
}
```

반면, 키가 정수가 아닌 경우는 키의 생성 순서대로 나열된다.

```js
let user = {
  name: "John",
  surname: "Smith"
};
user.age = 25; // 추가

for (let prop in user) {
  alert(prop); // name, surname, age
}
```

정수인 경우에도 약간의 속임수로 생성된 순서로 출력할 수 있다.

```js
let codes = {
  "+49": "Germany",
  "+41": "Switzerland",
  "+44": "Great Britain",
  // ..,
  "+1": "USA"
};

for (let code in codes) {
  alert(+code); // 49, 41, 44, 1
}
```

## 참조 복사

객체와 원시 자료형의 기본적인 차이점 중 하나는 객체는 참조로 저장 및 복사된다는 것이다.

기본형은 `값복사`를 한다.

```js
let message = "Hello!";
let phrase = message;
```

객체는 메모리의 주소, 즉 `레퍼런스`를 저장한다.

```js
let user = { name: "John" };

let admin = user;

admin.name = "Pete"; //  "admin" 을 고쳤지만

alert(user.name); // 'Pete', "user" 도 바뀌었다.
```

즉 객체는 하나만 있고 그걸 참조하는 변수가 두개가 있는 것이다.

## 참조에 의한 비교

객체 비교도 마찬가지로 객체인 경우에만 동일할 경우에만 동일하다.

```js
let a = {};
let b = a; // 레퍼런스 복사

alert(a == b); // true, 같은 레퍼런스
alert(a === b); // true
```

독립된 객체는 비어 있어도 동일하지 않다.

```js
let a = {};
let b = {}; // 독립된 빈 객체

alert(a == b); // false
```

## Const 객체

기본 자료형의 경우 `const`는 변경할 수 없지만, 객체인경우는 변경이 가능하다.

```js
const user = {
  name: "John"
};

user.age = 25; // 오류는 나지 않는다.

alert(user.age); // 25
```

객체 변수는 참조를 저장한다고 하였다. 즉 참조를 변경하지 않으면 `const`를 해치지 않는것이기 때문에 내부를 수정할 수 있다.

참조를 변경하려 한다면 오류가 난다.

```js
const user = {
  name: "John"
};

// Error (user를 재할당 할 수 없다.)
user = {
  name: "Pete"
};
```

## 복제와 병합, Object.assign

객체 변수를 복사하면 동일한 객체에 대한 참조가 하나 더 생성된다.

그렇다면 객체를 복제해야하는 경우는 어떻게 해야할까? 사실 대부분의 경우는 참조 복사가 더 좋지만 간혹 필요한 경우가 있다.

그러나 객체를 복제하려면 객체를 생성하고 그것의 속성을 반복해서 원시레벨 복사와 구조를 복사해야한다.

```js
let user = {
  name: "John",
  age: 30
};

let clone = {}; // 빈 객체 생성

// 유저를 클론에 복사
for (let key in user) {
  clone[key] = user[key];
}

// 독립된 객체로 복제 되었다.
clone.name = "Pete"; // 클론의 데이터를 바꾸어도

alert(user.name); // 본 객체는 변경되지 않는다.
```

다른 방법으로는 `Object.assign` 메소드를 사용할 수 있다. 구문은 다음과 같다.

```js
Object.assign(dest, [src1, src2, src3...])
```

- `dest`는 `src1, ..., srcN`의 객체이다.
- 두번째 인자부터 모든 소스를 `dest`에 복사한다.

즉, 여러 객체를 하나로 병합하는 데 사용할 수 있다.

```js
let user = { name: "John" };

let permissions1 = { canView: true };
let permissions2 = { canEdit: true };

// permissions1 과 permissions2 를 user에 복사
Object.assign(user, permissions1, permissions2);

// 이제 user = { name: "John", canView: true, canEdit: true } 가 되었다.
```

수신 객체에 이미 동일한 속성이 있는 경우는 덮어 쓴다.

```js
let user = { name: "John" };

// name을 덮어쓰고, isAdmin 추가
Object.assign(user, { name: "Pete", isAdmin: true });

// now user = { name: "Pete", isAdmin: true }
```

클론을 하는데에 사용할 수도 있다.

```js
let user = {
  name: "John",
  age: 30
};

let clone = Object.assign({}, user);
```

그렇다면 속성중에 객체가 있는경우는 어떨까?

```js
let user = {
  name: "John",
  sizes: {
    height: 182,
    width: 50
  }
};

let clone = Object.assign({}, user);

alert(user.sizes === clone.sizes); // true, 같은 오브젝트

// user 와 clone 은 sizes 참조를 공유한다.
user.sizes.width++; // user를 증가시키면
alert(clone.sizes.width); // 51, clone도 증가된다.
```

즉 `user[key]`가 객체인 경우 해당 구조도 복제해야한다. 이를 `딥클로닝`이라고 한다.

# 숙제

## 오브젝트와 친해지기

1. `user` 빈 객체를 만들자.
2. `name`속성을 `John`으로 추가하자.
3. `surname`속성을 `Smith`으로 추가하자.
4. `name`속성을 `Pete`로 변경하자.
5. `name`속성을 제거하자.

## 빈 객체 점검

`isEmpth(obj)`가 객체에 속성이 없으면 불리언을 반환하도록 작성하자.

아래처럼 동작하도록 해보자.

```js
let schedule = {};

alert(isEmpty(schedule)); // true

schedule["8:30"] = "get up";

alert(isEmpty(schedule)); // false
```

## Const 객체

아래 코드는 동작하는 코드인가?

```js
const user = {
  name: "John"
};

// 동작하는가?
user.name = "Pete";
```

## 객체 속성을 합해보자

팀의 급여를 저장하는 객체가 있다. 모든 급여를 합산하고 `sum`변수에 저장하는 코드를 작성해보자. 답은 아래의 경우 `390`이다.

```js
let salaries = {
  John: 100,
  Ann: 160,
  Pete: 130
};
```

`salaries`가 비어있으면 결과는 `0`이 나와야한다.

## 숫자 속성에 2를 곱하기

`multiplyNumeric(obj)`로 모든 객체의 숫자 속성에 2를 곱하도록 만들어보자.

```js
// 호출 전
let menu = {
  width: 200,
  height: 300,
  title: "My menu"
};

multiplyNumeric(menu);

// 호출 이후
menu = {
  width: 400,
  height: 600,
  title: "My menu"
};
```

`multiplyNumeric`은 아무것도 반환하지 않는다. 객체를 제자리에서 수정한다.

팁: `typeof`를 사용하여 숫자를 감별할 수 있다.
