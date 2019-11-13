---
layout: post
title: "[모던자바스크립트] 25. 심볼 타입"
subtitle: "modern javascript, 심볼 타입"
categories: devlog
tags: javascript
comments:
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# 심볼타입

객체 속성 키는 문자열 타입이거나 심볼 타입일 수 있다. 지금까지는 문자열만을 사용하였는데, 이제 심볼타입에 대해서 알아보자.

## 심볼

심볼은 고유 식별자를 이야기한다. 이 타입의 값은 다음처럼 만들 수 있다.

```js
let id = Symbol();
```

작성시 심볼설명(심볼이름)을 제공할 수 있으며 대부분 디버깅 목적으로 사용된다.

```js
let id = Symbol("id");
```

심볼은 고유하다. 동일한 설명으로 많은 심볼을 작성하더라도 다른 값이다.

```js
let id1 = Symbol("id");
let id2 = Symbol("id");

alert(id1 == id2); // false
```

다른 언어의 심볼과는 다른 점이 있으니 헷갈리지 않도록 주의하자.

### 심볼은 문자열로 자동변환되지 않는다.

자바스크립트의 대부분의 값은 문자열로의 암시적 변환을 지원한다. 우리는 `alert`에 모든 값을 넣을 수 있으면 작동한다. 하지만 심볼은 그렇지 않다.

```js
let id = Symbol("id");
alert(id); // TypeError: Cannot convert a Symbol value to a string
```

문자열과 심볼은 근본적으로 다르고 실수로 서로 변환해서는 안되므로 `언어 보호` 차원의 방어책이다.

심볼은 표시하고 싶다면 `toString`이나 `symbol.description`을 사용하여 표시할 수 있다.

```js
let id = Symbol("id");
alert(id.toString()); // Symbol(id)
```

```js
let id = Symbol("id");
alert(id.description); // id
```

## 히든 속성

심볼을 사용하면 객체의 히든속성을 만들 수 있다. 코드로는 실수로 심볼을 액세스할 수 없기때문에 안전하다.

### 리터럴 기호

```js
let id = Symbol("id");

let user = {
  name: "John",
  [id]: 123 // not "id: 123"
};
```

심볼을 이용할떄.

### 심볼은 몇몇 루프에 참여하지 않는다.

```js
let id = Symbol("id");
let user = {
  name: "John",
  age: 30,
  [id]: 123
};

for (let key in user) alert(key); // name, age (symbol은 없다)

// 직접 접근하면 나타난다.
alert("Direct: " + user[id]);
```

`for..in` 루프를 비롯 `Object.keys`에도 참여하지 않는다. 히든 속성의 원리이다. 하지만 `Object.assign`은 문자열 및 심볼 속정을 모두 복사한다.

```js
let id = Symbol("id");
let user = {
  [id]: 123
};

let clone = Object.assign({}, user);

alert(clone[id]); // 123
```

## 글로벌 심볼

앞에선 본 것처럼 이름이 같더라도 일반적으로 모든 심볼은 다르다. 그러나 때로는 동일한 이름의 심볼이 동일한 엔티티가 되기를 원한다. 예를들어 프로그램의 다른 부분에서 동일한 속성을 의미하는 심볼에 접근하려 할 때가 있다.

이를 위해 전역 심볼 레지스트리가 있다. 심볼을 만들어 나중에 액세스 할 수 있으며 같은 이름으로 반복 액세스 할 때 정확히 동일한 심볼이 반환되도록 한다.

레지스트리에서 심볼을 읽으려면 `Symbol.for(key)`를 사용한다.

이 호출은 전역 레지스트리를 검사하고 설명이 있는 `키`가 있는 경우 이를 리턴한다. 그렇지 않으면 새 심볼을 작성해 저장한다.

```js
// 전역 레지스트리에서 읽기
let id = Symbol.for("id"); // 심볼이 없다면, 생성한다.

// 다시 한번 읽기
let idAgain = Symbol.for("id");

// 같은 심볼
alert(id === idAgain); // true
```

### Symbol.keyFor

전역 심볼은 `Symbol.for(key)`로 심볼을 반환하기도 하지만 `Symbol.keyFor(sym)`으로 이름을 반환하기도 한다.

```js
// 이름으로 심볼 얻기
let sym = Symbol.for("name");
let sym2 = Symbol.for("id");

// 심볼로 이름 얻기
alert(Symbol.keyFor(sym)); // name
alert(Symbol.keyFor(sym2)); // id
```

심볼이 전역이 아닌경우는 찾아 낼 수 없다.

```js
let globalSymbol = Symbol.for("name");
let localSymbol = Symbol("name");

alert(Symbol.keyFor(globalSymbol)); // name, 전역 심볼
alert(Symbol.keyFor(localSymbol)); // undefined, 전역이 아니다

alert(localSymbol.description); // name
```

## 시스템 심볼

자바스크립트가 내부적으로 사용하는 많은 시스템심볼이 있으며, 이를 사용하여 객체의 다양한 측면을 미세 조정할 수 있다.

- Symbol.hasInstance
- Symbol.isConcatSpreadable
- Symbol.iterator
- Symbol.toPrimitive
- …등등
