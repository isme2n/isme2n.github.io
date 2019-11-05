---
layout: post
title: "[모던자바스크립트] 20. 코멘트"
subtitle: "modern javascript, 코멘트"
categories: devlog
tags: javascript
comments: true
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# 코멘트

우리는 주석을 어떻게 하는지 이미 공부했다. 언뜻 보기에는 주석을 사용하는게 너무 타당하지만, 초보 개발자는 종종 오용을 하곤한다.

## 나쁜 주석

초보 개발자는 `코드에서 무슨 일이 일어나고 있는지` 설명하기 위해 주석을 사용하곤한다.

```
// 이 코드는 A를 하고 B를 합니다
// 어쩌고 저쩌고
very;
complex;
code;
```

하지만 좋은 코드는 `설명적인 주석`은 최소화될 필요가 있다.

우리에겐 `코드가 명확하지 않아 주석이 필요하다면 코드를 다시 작성해야한다.`라는 훌륭한 규칙이 있다.

## 함수 분해로 나쁜 주석을 제거

종종 코드를 함수로 바꾸는게 유리하다.

```
function showPrimes(n) {
  nextPrime:
  for (let i = 2; i < n; i++) {

    // 소수인지 확인
    for (let j = 2; j < i; j++) {
      if (i % j == 0) continue nextPrime;
    }

    alert(i);
  }
}
```

```
function showPrimes(n) {

  for (let i = 2; i < n; i++) {
    if (!isPrime(i)) continue;

    alert(i);
  }
}

function isPrime(n) {
  for (let i = 2; i < n; i++) {
    if (n % i == 0) return false;
  }

  return true;
}
```

함수자체가 주석이 되는것이다. 이런 코드를 `자기설명적`이라고 한다.

## 좋은 주석

설명적 주석은 일반적으로 좋지 않다고 했다. 그럼 어떤 주석이 좋은 주석일까?

### 아키텍쳐 설명

구성 요소, 상호 작용 방식, 다양한 상황에서의 제어 흐름에 대한 개요를 제공하는것이 좋다. 간단히 말해 `코드의 조감도` 말이다. 코드를 설명하는 고급 아키텍쳐 다이어그램을 작성하기 위한 특수한 언어인 `UML`이 있으며 이는 시간을 들여 공부할 가치가 있다.

### 함수의 사용과 매개 변수

사용법, 매개 변수, 리턴 값과 같은 함수를 문서화하는 `JSDoc`이라는 구문도 있다.

```
/**
 * Returns x raised to the n-th power.
 *
 * @param {number} x The number to raise.
 * @param {number} n The power, must be a natural number.
 * @return {number} x raised to the n-th power.
 */
function pow(x, n) {
  ...
}
```

웹스톰같은 에디터에는 이를 이해하고 자동완성 및 확인해볼 수 있는 기능을 제공한다.

또한 주석에서 HTML 문서를 생성할 수 있는 `JSDoc 3`등의 도구도 있다. 궁금하다면 (공식문서)[http://usejsdoc.org] 에서 확인할 수 있다.
