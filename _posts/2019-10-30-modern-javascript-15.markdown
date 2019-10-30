---
layout: post
title: "[모던자바스크립트] 15. 함수"
subtitle: "modern javascript, 함수"
categories: devlog
tags: javascript
comments: true
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# 함수

대부분의 경우 스크립트의 여러 곳에서 유사한 작업을 수행해야 할 경우가 있다.

우리가 여태껏 유용하게 써왔던 `alert`가 대표적인 예이다.

## 함수 선언

```
function name(parameters) {
  ...body...
}
```

함수는 위처럼 선언한다.

```
function showMessage() {
  alert( 'Hello everyone!' );
}

showMessage();
showMessage();
```

함수를 선언할때는 alert가 실행되지 않는다.

함수 이름으로 호출할 수 있으며, 실제 호출 될 떄에 내부의 내용이 실행된다.

## 지역 변수

함수안에서 선언 된 변수는 해당 함수 안에서만 볼 수 있다.

```
function showMessage() {
  let message = "Hello, I'm JavaScript!"; // 지역변수

  alert( message );
}

showMessage(); // Hello, I'm JavaScript!

alert( message ); // <-- Error!
```

## 외부 변수

내부 변수는 외부에서 볼 수 없지만, 외부의 변수는 함수 내부에서 볼 수 있다.

```
let userName = 'John';

function showMessage() {
  let message = 'Hello, ' + userName;
  alert(message);
}

showMessage(); // Hello, John
```

## 매개 변수 parameters

함수의 인수(arguments) 라고도 하며, 데이터를 함수에 전달 할 수 있다.

```
function showMessage(from, text) { // arguments: from, text
  alert(from + ': ' + text);
}

showMessage('Ann', 'Hello!'); // Ann: Hello!
showMessage('Ann', "What's up?"); // Ann: What's up?
```

## 기본 값

매개 변수가 전해지길 기대하는데, 실제로 전해지지 않았을 경우를 대비해 기본값을 설정할 수 있다.

```
function showMessage(from, text = "no text given") {
  alert( from + ": " + text );
}

showMessage("Ann"); // Ann: no text given
```

text가 전해졌다면 기본값은 무시된다.

현재 자바스크립트의 버전이 올라가면서 기본값이 지원되지만, 예전코드에서는 종종 기본값을 위해 아래와 같은 방식으로 사용되었다.

```
function showMessage(from, text) {
  if (text === undefined) {
    text = 'no text given';
  }

  alert( from + ": " + text );
}
```

또는

```
function showMessage(from, text) {
  text = text || 'no text given';
  ...
}
```

## 값 반환

함수는 자신을 호출한 곳으로 값을 반환할 수 있다.

```
function sum(a, b) {
  return a + b;
}

let result = sum(1, 2);
alert( result ); // 3
```

함수는 이 후에 코드가 남았더라도 return을 만나면 종료하고 값을 반환한다.

```
function checkAge(age) {
  if (age > 18) {
    return true;
  } else {
    return confirm('Do you have permission from your parents?');
  }
}

let age = prompt('How old are you?', 18);

if ( checkAge(age) ) {
  alert( 'Access granted' );
} else {
  alert( 'Access denied' );
}
```

아무값도 주지 않고 return할 수 있으며 undefined와 같다.

```
function doNothing() {
  return;
}

alert( doNothing() === undefined ); // true
```

return을 여러줄에 걸쳐 작성하고 싶다면 괄호로 묶을 수 있다.

```
return (
  some + long + expression
  + or +
  whatever * f(a) + f(b)
  )
```

## 함수 이름

함수 이름은 팀내에서 약속을 정하는 것이 좋다.

예를 들면 아래와 같다.

- "get…" – 값을 반환
- "calc…" – 무언가를 계산하고
- "create…" – 무언가를 만들고
- "check…" – 무언가를 확인하고 부울 등을 반환한다.

변수와 마찬가지로 함수이름을 잘 짓는것도 중요하다.

### 하나의 함수는 하나의 행동만을 하는것이 좋다

함수는 이름에 걸맞는 행동 단 하나만을 하는것이 중요하다.

추후 문제가 생겼을 때 그 기능을 담당하는 곳이 어딘지 명확하게 알 필요가 있기때문이다.

예를 들어 `getAge`함수 내부에서 `alert`를 실행한다면 명확하지 않은 예라고 할 수 있다. 이런 경우에는 값을 반환받은 곳에서 `alert`를 동작시켜야한다.

## 함수 이름은 주석과도 같다

소수를 출력하는 함수를 보자.

```
function showPrimes(n) {
  nextPrime: for (let i = 2; i < n; i++) {

    for (let j = 2; j < i; j++) {
      if (i % j == 0) continue nextPrime;
    }

    alert( i ); // 소수이다
  }
}
```

이걸 함수를 이용하여 더 명확하게 알 수 있도록 해보자.

```
function showPrimes(n) {

  for (let i = 2; i < n; i++) {
    if (!isPrime(i)) continue;

    alert(i);  // 소수
  }
}

function isPrime(n) {
  for (let i = 2; i < n; i++) {
    if ( n % i == 0) return false;
  }
  return true;
}
```

함수를 사용함으로써 명확하게 어떤 의미를 가진 코드인지 파악할 수 있다.

# 숙제

## else가 필요한코드인가?

다음의 함수는 age가 18보다 큰경우 true를 반환하는 함수이다.

```
function checkAge(age) {
  if (age > 18) {
    return true;
  } else {
    return confirm('Did parents allow you?');
  }
}
```

else가 없더라도 똑같이 동작하는가?

```
function checkAge(age) {
  if (age > 18) {
    return true;
  }
  return confirm('Did parents allow you?');
}
```

## 최소값 함수

`min(a, b)`로 실행할 수 있는, 두개의 솟자를 받아 둘 중 작은 값을 반환하는 함수를 작성해보자.

예시 값

```
min(2, 5) == 2
min(3, -1) == -1
min(1, 1) == 1
```

## 지수 함수

`pow(x, n)`으로 동작하는 지수 함수를 만들자.

```
pow(3, 2) = 3 * 3 = 9
pow(3, 3) = 3 * 3 * 3 = 27
pow(1, 100) = 1 * 1 * ...* 1 = 1
```
