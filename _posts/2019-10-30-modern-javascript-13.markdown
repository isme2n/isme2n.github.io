---
layout: post
title: "[모던자바스크립트] 13. 반복"
subtitle: "modern javascript, 반복"
categories: devlog
tags: javascript
comments: true
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# 반복

종종 반복된 행동을 해야하는 경우가 있다.

## while 루프

`while`루프는 다음 처럼 사용한다.

```
while (condition) {
  // code
  // 이부분을 “loop body" 라고 부른다.
}
```

조건이 true인 동안 루프바디가 계속 실행된다.

예를 들어 다음 코드는 3번 실행된다.

```
let i = 0;
while (i < 3) { // 0, 1, 2 를 순차적으로 보여준다.
  alert( i );
  i++;
}
```

한 줄 짜리 바디에는 중괄호가 필요하지 않다.

```
let i = 3;
while (i) alert(i--);
```

## do…while 루프

```
do {
  // loop body
} while (condition);
```

`while`과 다른 점은 `무조건 한번`은 실행된다는것이다.

자주 사용되는 편은 아니라고 생각한다.

## for 루프

가장 일반적으로 사용되는 루프이다.

```
for (begin; condition; step) {
  // ... loop body ...
}
```

```
for (let i = 0; i < 3; i++) { // 0, 1, 2 를 출력한다.
  alert(i);
}
```

- Begin: 루프에 들어가면 한 번 실행된다.
- Condition: 모든 루프 반복 전에 확인된다. false면 중지된다.
- Body: 실행되는 내용이 적혀있다.
- Step: 각 반복에서 Body이후에 실행된다.

### 생략

각 부분은 생략이 가능하다.

아래와 같은경우는 Begin, Condition, Step을 생략한 코드로. While과 같은 동작을 한다.

```
for (;;) {
  // repeats without limits
}
```

## 루프 깨기

반복문을 강제로 종료하고 나올 수 있는 `break`를 사용할 수 있다.

```
let sum = 0;

while (true) {

  let value = +prompt("Enter a number", '');

  if (!value) break;

  sum += value;

}
alert( 'Sum: ' + sum );
```

사용자가 falsy 값을 제공할 경우 break로 빠져나온다.

## 루프 진행

break의 경량버전이라고 생각 할 수 있다. break는 루프 전체를 멈춘다고 생각하면 continue는 현재 반복을 멈추고 다음 반복으로 넘어가는 것이다.

```
for (let i = 0; i < 10; i++) {

  if (i % 2 == 0) continue;

  alert(i); // 1, 3, 5, 7, 9
}
```

위의 코드는 홀수만 출력하는 코드이다.

## break/continue 용 라벨

한번에 여러개의 중첩루프에서 벗어나야 할 때가 있다.

```
outer: for (let i = 0; i < 3; i++) {

  for (let j = 0; j < 3; j++) {

    let input = prompt(`Value at coords (${i},${j})`, '');

    if (!input) break outer; // 한번에 두개의 루프를 탈출한다.

    // 쿵짝쿵짝
  }
}
alert('Done!');
```

# 숙제

## 마지막 루프 값은?

```
let i = 3;

while (i) {
  alert( i-- );
}
```

## 어떤 값인가?

출력되는 값을 기록하고 두 식을 비교해보자.

둘다 같은 값을 반복하는가?

1.

```
let i = 0;
while (++i < 5) alert( i );
```

2.

```
let i = 0;
while (i++ < 5) alert( i );
```

## for루프의 값

두 루프를 비교하라.

1.

```
for (let i = 0; i < 5; i++) alert( i );
```

2.

```
for (let i = 0; i < 5; ++i) alert( i );
```

## 루프에서 짝수를 출력

for루프는 사용하여 2부터 10까지 짝수를 출력하라.

## for를 while로 교체

출력을 동일하게 유지한체 while문으로 수정해보자.

```
for (let i = 0; i < 3; i++) {
  alert( `number ${i}!` );
}
```

## 입력이 올 때까지 반복

100보다 큰 수를 묻는 반복문을 작성해보자. 100보다 큰 숫자를 입력하거나 falsy값인 경우가 아니라면 계속 값을 입력받는다.

## 소수 출력

10보다 작은 소수를 찾는 코드를 작성해보자.

1과 자신을 제외하고 나눌 수 없는 수를 소수라고 한다.
