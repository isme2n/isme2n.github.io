---
layout: post
title: '[모던자바스크립트] 30. 원시형의 메소드'
subtitle: 'modern javascript, 원시형의 메소드'
categories: devlog
tags: javascript
comments: true
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# 숫자

모던 자바스크립트에는 두 가지 유형의 숫자가 있다.

1. 일반적인 숫자는 `double precision floating point numbers`라고 하는 64비트의 IEEE-754를 따르는 형식이다. 이 숫자들은 가장 많이 사용하는 숫자이며, 이번에 다룰 것이 이것이다.
2. 임의 길이의 정수를 나타내는 BigInt 숫자. 일반 숫자는 `2^53`, `-2^53`을 초과할 수 없으므로 필요한 형식이다. 몇가지 특수한 경우에 사용되므로 나중에 한번 다루어 보도록하자.

## 숫자를 쓰는 다양한 방법

10억을 써야한다면 어떻게 쓸까? 일반적으로는 아래처럼 쓸것이다.

```js
let billion = 1000000000;
```

그러나 실제로는 잘못 입력하기 쉽기 때문에 일반적으로 길게 늘어 사용하지 않는다. 우리는 현실세계에서는 `1bn`같은 형식으로 사용하며 자바스크립트에서도 비슷하다.

자바스크립트에서는 `e`를 숫자에 추가하고 0의 카운트를 지정하여 짧게 사용한다.

```js
let billion = 1e9;
```

즉, `e`는 숫자에 0의 숫자만큼 곱한다.

```js
1e3 = 1 * 1000;
1.23e6 = 1.23 * 1000000;
```

이제 작은 숫자도 적어보자. 1 마이크로 초 (백만분의 1초)

```js
let ms = 0.000001;

// or

let ms = 1e-6;
```

## 16진수, 2진수 및 8진수

16진수는 자바스크립트에서 널리 사용되며 색상을 표현하거나 문자를 인코딩하는 등 많은 목적으로 사용된다. 자연스럽게 `0x`라는 16진수를 쓰는 더 짧은 방법이 있다.

```js
alert(0xff); // 255
alert(0xff); // 255 (같다. 대소문자는 구분하지 않는다)
```

이진수 및 8진수는 거의 사용되지 않지만 `0b`, `0o` 접두사를 사용하여 지원된다.

```js
let a = 0b11111111; // 이진수 255
let b = 0o377; // 8진수 255

alert(a == b); // true, 255 인 건 똑같다.
```

## toString(base)

`number.toString(base)`는 숫자를 `base`진수화 하여 표현한다.

```js
let num = 255;

alert(num.toString(16)); // ff
alert(num.toString(2)); // 11111111
```

기본적으로는 `base`는 `10`이다. `36`이 최대값이며 `0..9`, `a..z`를 모두 표현할 수 있어 숏링크같은 경우는 36진수로 나타내곤한다.

```js
alert((123456).toString(36)); // 2n9c
```

여기서 `..`은 오타가 아니며 숫자에 사용하기 위해서는 `..`을 사용해야한다. 사용하지 않는다면 마지막 숫자에만 적용이 된다(지금의 경우에는 6에만). 다른 방법은 `(123456).toString(36)`이 있다.

## 반올림

숫자로 작업할 때 가장 많이 사용되는 작업 중 하나는 반올림이다. 그를 위한 몇가지 내장함수가 있다.

### Math.floor

버림이다. `3.1 => 3`, `-1.1 => -2`

### Math.ceil

올림이다. `3.1 => 4`, `-1.1 => -1`

### Math.round

반올림. `3.1 => 3`, `3.6 => 4`, `-1.1 => -1`

### Math.trunc (IE에서 지원되지 않음)

소수점 제거. `3.1 => 3`, `-1.1 => -1`

그럼 소수점 둘째자리에서 반올림을 하고 싶다면 어떻게 할까? 2가지 방법이 있다.

### 1. 곱하고 나누기

```js
let num = 1.23456;
alert(Math.floor(num * 100) / 100); // 1.23456 -> 123.456 -> 123 -> 1.23
```

### 2. toFixed(n) : 소수점 n째 자리로 반올림하고 문자열을 반환

```js
let num = 12.34;
alert(num.toFixed(1)); // "12.3"

// 반올림

let num = 12.36;
alert(num.toFixed(1)); // "12.4"
```

`toFixed`의 결과는 문자열이다. 소수 부분이 필요한것보다 짧으면 끝에 0이 추가된다.

```js
let num = 12.34;
alert(num.toFixed(5)); // "12.34000"
```

## 부정확한 계산

숫자를 저장하는 데 사용하는 64비트가 있다. 52개는 숫자를 저장하는데 사용되고 11개는 소수점 위치를 저장한다. 부호는 1비트이다.

숫자가 너무 크면 64비트 스토리지를 오버플로하여 무한대를 얻을 수 있다.

```js
alert(1e500); // Infinity
```

정밀도를 잃어버리는 경우가 있다.

```js
alert(0.1 + 0.2 == 0.3); // false
```

뭐지? 0.1 + 0.2 가 0.3이 아니면 뭐지?

```js
alert(0.1 + 0.2); // 0.30000000000000004
```

만약 돈 거래 였다면 우리는 `$0.1` 와 `$0.2`를 구매했는데 `$0.30000000000000004` 를 내야한다면 위험할 수도 있다.

왜 이런일이 발생할까?

숫자는 이진 형식으로 메모리에 저장된다. 그러나 `0.1`같은 것은 `1/10`로 저장된다. 그리고 이러한 값들은 끝나지 않는 파편으로 남아 있다. 예를들면 `1/3` 처럼 `0.33333(3)`처럼 되는것이다.

정확히 `0.1`, `0.2`를 저장하는 방법은 없다. 가능한 가장 가까운 숫자로 반올림하여 이 문제를 해결하는데. 작은 정밀도 손실로 편의성을 얻은 것이다.

```js
alert((0.1).toFixed(20)); // 0.10000000000000000555
```

두 숫자를 합하면 저 정밀 손실들이 더해지므로 정확히 0.3이 나오지 않는다.

이는 자바스크립트뿐만아니라 `PHP, Java, C, Perl, Ruby` 등에서도 발생한다.

그럼 문제를 해결할 수는 없을까?

가장 신뢰할 수 있는 방법은 `toFixed`를 사용하는 것이다.

```js
let sum = 0.1 + 0.2;
alert(+sum.toFixed(2)); // 0.3
```

재밌는 경우가 있다.

```js
// 스스로 증가해버렸다.
alert(9999999999999999); // 10000000000000000
```

또한 이 숫자 체계에서는 `0` 과 `-0`이 존재한다.

## isFinite 및 isNaN

두 특수 숫자 값이 기억나는가?

- `Infinity`(`-Infinity`)는 다른 것보다 큰(작은) 특수 숫자 값이다.
- `NaN` 오류

이들은 `number`타입에 속하지만 정상적인 숫자는 아니기 때문에 이를 확인하는 특수 함수가 있다.

### isNaN(value): 인수를 숫자로 변환 한 후 NaN과 같은지 비교

```js
alert(isNaN(NaN)); // true
alert(isNaN('str')); // true
```

이 기능말고 그냥 `=== NaN`처럼 비교하면 안되나? 답은 `안된다`. 값 `NaN`은 자신을 포함하여 아무것도 같지 않다.

```js
alert(NaN === NaN); // false
```

### isFinite(value): 인수를 숫자로 변환하고 일반 숫자일 경우 true를 반환한다.

```js
alert(isFinite('15')); // true
alert(isFinite('str')); // false, NaN 이라서
alert(isFinite(Infinity)); // false, Infinity 라서
```

### Object.is

`===`이 있지만 `Object.is`가 비교에 있어 2가지 안정적인 경우가 있다.

1. `NaN`: `Object.is(NaN, NaN) === true`
2. `0` 과 `-0`: `Object.is(0, -0) === false`, 부호비트가 다르다.

다른 경우에는 강한 비교와 모두 같은 결과를 낸다.

## parseInt 및 parseFloat

단항 더하기를 사용하거나 `Number()`를 사용하면 엄격하기 때문에 값이 정확히 숫자가 아닌 경우 실패한다.

```js
alert(+'100px'); // NaN
```

이럴 때 사용하는 것이 `parseInt` 와 `parseFloat`이다. 문자열에서 찾을 수 없을때까지 숫자를 읽고 오류가 있을경우 숫자가 반환된다. `parseInt`는 정수를 `parseFloat`는 부동 소수점 숫자를 반환한다.

```js
alert(parseInt('100px')); // 100
alert(parseFloat('12.5em')); // 12.5

alert(parseInt('12.3')); // 12, 정수부분
alert(parseFloat('12.3.4')); // 12.3, 두번째 점에서 에러
```

`NaN`이 반환될 때가 있는데, 처음부터 에러를 만났을 때이다.

```js
alert(parseInt('a123')); // NaN
```

몇진수로 출력할 지도 선택할 수 있다.

```js
alert(parseInt('0xff', 16)); // 255
alert(parseInt('ff', 16)); // 255, 0x가 없어도 된다.

alert(parseInt('2n9c', 36)); // 123456
```

## 다른 수학 함수

몇가지 수학 함수와 상수가 포함된 내장 `Math` 객체가 있다.

### Math.random()

0에서 1사이의 난수를 반환한다.(1 제외)

```js
alert(Math.random()); // 0.1234567894322
alert(Math.random()); // 0.5435252343232
```

### Math.max(a, b, c....) / Math.min(a, b, c....)

임의의 수의 인수에서 최대 / 최소를 반환한다.

```js
alert(Math.max(3, 5, -10, 0, 1)); // 5
alert(Math.min(1, 2)); // 1
```

### Math.pow(n, power)

`n` 을 `power`지수한 값 반환

```js
alert(Math.pow(2, 10)); // 2 ^ 10 = 1024
```

# 숙제

## 합계

방문자에게 두 개의 숫자를 입력하라는 메시지를 표시한 다음 합계를 표시하는 스크립트를 작성하라.

타입에 유의하자.

## 왜 6.35.toFixed(1) == 6.3 인가?

```js
alert((6.35).toFixed(1)); // 6.3
```

제대로 반올림하려면 어떻게 해야하는가?

## 입력 값이 숫자일 때까지 반복

`readNumber`에 방문자가 유효한 숫자를 입력할 때까지 숫자를 묻는 함수를 작성하라.

결과 값은 숫자로 반환되어야한다.

방문자는 빈 줄을 입력하거나 `취소`를 눌러 프로세스를 중지 할 수도 있다. 이 경우 함수는 `null`을 반환해야한다.

## 무한루프

이 루프는 무한하다. 왜?

```js
let i = 0;
while (i != 10) {
  i += 0.2;
}
```

## 최소에서 최대까지 난수

`random(min, max)`함수를 만들어 최소값부터 최대값사이의 부동소수점을 표현하도록 만들어보자.

```js
alert(random(1, 5)); // 1.2345623452
alert(random(1, 5)); // 3.7894332423
alert(random(1, 5)); // 4.3435234525
```

<details markdown="1">
<summary>답</summary>

```js
function random(min, max) {
  return min + Math.random() * (max - min);
}
```

</details>

## 최소에서 최대까지 임의의 정수

`randomInteger(min, max)`함수를 만들어 최소값부터 최대값사이의 정수을 표현하도록 만들어보자. 확률이 같게 나오려면 세심한 주의가 필요하다.

```js
alert(randomInteger(1, 5)); // 1
alert(randomInteger(1, 5)); // 3
alert(randomInteger(1, 5)); // 5
```

<details markdown="1">
<summary>답</summary>

```js
function randomInteger(min, max) {
  // rand 는 min 부터 (max+1)
  let rand = min + Math.random() * (max + 1 - min);
  return Math.floor(rand);
}

// 또는

function randomInteger(min, max) {
  // rand 는 (min-0.5) 부터 (max+0.5)
  let rand = min - 0.5 + Math.random() * (max - min + 1);
  return Math.round(rand);
}
```

</details>
