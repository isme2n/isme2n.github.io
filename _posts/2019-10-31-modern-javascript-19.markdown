---
layout: post
title: "[모던자바스크립트] 19. 코딩 스타일"
subtitle: "modern javascript, 코딩 스타일"
categories: devlog
tags: javascript
comments: true
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# 코딩 스타일

코드는 가능한 깔끔하고 읽기 쉬워야한다.

실제로 개발자에게 요구되는 역량이기도하며, 복잡한 작업을 수행하여도 사람이 잘 읽을 수 있도록 코딩하는것이 좋다.

## 문법

정답은 아니다. 하지만 `이렇게 해보니 좀 더 읽기 좋더라` 라는 많은 회사와 개발자 선배들의 경험 중에 대표적인 것 몇개를 짚어보자.

### 중괄호

대부분의 자바스크립트 코드는 중괄를 여는 줄에 함께 적는다. 괄호사이에 공간도 있다.

```
if (condition) {
  // 이런식이다
  // ...어쩌고
  // ...저쩌고
}
```

한 줄 짜리 `if`문은 중괄호를 필요로 하지 않지만 권장된다.

```
if (n < 0) alert(`Power ${n} is not supported`); // 이것보다는

// 이게 권장된다.
if (n < 0) {
  alert(`Power ${n} is not supported`);
}
```

### 선길이

긴 가로줄은 읽기에 좋지 않다. 줄을 나누어서 작성하는게 좋다.

```javascript
// 백틱 ` 은 여러줄이 허용된다.
let str = `
  Ecma International's TC39 is a group of JavaScript developers,
  implementers, academics, and more, collaborating with the community
  to maintain and evolve the definition of JavaScript.
`;
```

또한 if문 등에서도

```
if (
  id === 123 &&
  moonPhase === 'Waning Gibbous' &&
  zodiacSign === 'Libra'
) {
  letTheSorceryBegin();
}
```

이런식이 권장된다.

최대 줄 길이는 팀 수준에서 보통 합의가되며, 보통 80자에서 120자 정도이다.

### 들여쓰기

#### 가로들여쓰기: 2~4개의 공백

수평 들여쓰기는 2개 또는 4개의 공백 또는 탭을 사용하여 이루어진다. 공백이냐 탭이냐는 나는 큰 관심없는 문제이지만, 꽤 다툼이 일어나는 영역중에 하나이다.

탭보다 공백의 장점 중 하나는 공백이 더 유연하게 할 수 있다는것이다.

#### 세로들여쓰기

코드를 논리적으로 분할하기 위한 빈 줄이다.

```
function pow(x, n) {
  let result = 1;
  //              <--
  for (let i = 0; i < n; i++) {
    result *= x;
  }
  //              <--
  return result;
}
```

### 세미콜론

세미콜론이 있는 편이 명확하게 명령어 파악이 가능하다. 자바스크립트는 간혹 오류를 내는 경우가 있으니 세미콜론을 찍는걸 습관화하는걸 추천한다.

### 중첩

중첩을 너무 많이 하는것을 피하는 것이 좋다.

```
for (let i = 0; i < 10; i++) {
  if (cond) {
    ... // <- one more nesting level
  }
}
```

이것과

```
for (let i = 0; i < 10; i++) {
  if (!cond) continue;
  ...  // <- no extra nesting level
}
```

이것은 같은 코드이다.

```
function pow(x, n) {
  if (n < 0) {
    alert("Negative 'n' not supported");
  } else {
    let result = 1;

    for (let i = 0; i < n; i++) {
      result *= x;
    }

    return result;
  }
}
```

이것과

```
function pow(x, n) {
  if (n < 0) {
    alert("Negative 'n' not supported");
    return;
  }

  let result = 1;

  for (let i = 0; i < n; i++) {
    result *= x;
  }

  return result;
}
```

이것 역시 같은 코드이지만 좀 더 읽기 쉽다.

## 함수 배치

함수를 놓는 자리를 정하는 방법은 크게 3가지가 있다.

1. 함수를 사용하는 코드 위에 함수를 선언한다.

```
function createElement() {
  ...
}

function setHandler(elem) {
  ...
}

function walkAround() {
  ...
}

// the code which uses them
let elem = createElement();
setHandler(elem);
walkAround();
```

2. 먼저 코딩을 한 다음 함수를 선언한다.

```
let elem = createElement();
setHandler(elem);
walkAround();

function createElement() {
  ...
}

function setHandler(elem) {
  ...
}

function walkAround() {
  ...
}
```

3. 혼합방식. 함수가 사용된 곳에서 선언한다.

두번째 방식이 함수를 잘 지어서 코드가 이해가 되었다면 함수를 보지 않아도 되기때문에 선호된다.

## 스타일 가이드

스타일 가이드에는 코드 작성에 대한 일반적인 규칙(예 : 사용할 따옴표, 들여 쓰기 할 공간 수, 최대 줄 길이 등)이 포함되어 있다.

- Google 자바 스크립트 스타일 가이드
- Airbnb JavaScript 스타일 가이드
- Idiomatic.JS
- StandardJS

다양한 것들이 있다. 잘 살펴보고 왜 이렇게 생각했는지를 읽는것만으로도 많은 공부가 된다.

## 자동화 된 린터

린터는 코드 스타일을 자동으로 확인하고 갯선 제안을 할 수 있는 도구이다.

보통 `eslint`가 많이 사용되며 사용법은 아래와 같다.

1. Node.js를 설치한다.
2. `npm install -g eslint`(npm은 JavaScript 패키지 설치 프로그램)
3. 프로젝트의 루트에 `.eslintrc`를 작성한다.
4. 에디터의 플러그인 또는 기능을 활성화한다. (대부분의 에디터는 가지고 있다)

`.eslintrc`의 예

```
{
  "extends": "eslint:recommended",
  "env": {
    "browser": true,
    "node": true,
    "es6": true
  },
  "rules": {
    "no-console": 0,
    "indent": ["warning", 2]
  }
}
```

여기서 extends로 `eslint:recommended` 설정을 기반으로 하고, 커스텀을 한 것이다.

다른 스타일들을 기반으로 할 수도 있다.

# 숙제

## 아래 코드에 어떤 문제가 있는가? 고쳐보자

```
function pow(x,n)
{
  let result=1;
  for(let i=0;i<n;i++) {result*=x;}
  return result;
}

let x=prompt("x?",''), n=prompt("n?",'')
if (n<=0)
{
  alert(`Power ${n} is not supported, please enter an integer number greater than zero`);
}
else
{
  alert(pow(x,n))
}
```
