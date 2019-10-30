---
layout: post
title: "[모던자바스크립트] 14. 스위치"
subtitle: "modern javascript, 스위치"
categories: devlog
tags: javascript
comments: true
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# 스위치 문

`switch`문은 여러개의 ìf`검사를 대신할 수 있다.

```
switch(x) {
  case 'value1':  // if (x === 'value1')
    ...
    [break]

  case 'value2':  // if (x === 'value2')
    ...
    [break]

  default:
    ...
    [break]
}
```

일치하는 값이 있는 케이스를 실행하고, 없다면 default 케이스를 실행한다.

```
let a = 2 + 2;

switch (a) {
  case 3:
    alert( 'Too small' );
    break;
  case 4:
    alert( 'Exactly!' ); // 이게 출력됨.
    break;
  case 5:
    alert( 'Too large' );
    break;
  default:
    alert( "I don't know such values" );
}
```

break가 없다면 케이스 이후의 모든 코드가 실행된다.

```
let a = 2 + 2;

switch (a) {
  case 3:
    alert( 'Too small' );
  case 4:
    alert( 'Exactly!' );  // 이것도
  case 5:
    alert( 'Too big' ); //. 이것도
  default:
    alert( "I don't know such values" ); // 이것도 실행된다.
}
```

케이스는 변수나 표현식으로도 가능하다.

```
let a = "1";
let b = 0;

switch (+a) {
  case b + 1:
    alert("this runs, because +a is 1, exactly equals b+1");
    break;

  default:
    alert("this doesn't run");
}
```

### 케이스 그룹

케이스가 동일한 코드를 공유한다면 그룹화 시킬 수 있다.

```
let a = 2 + 2;

switch (a) {
  case 4:
    alert('Right!');
    break;

  case 3: // 두 케이스를 그룹화함.
  case 5:
    alert('Wrong!');
    alert("Why don't you take a math class?");
    break;

  default:
    alert('The result is strange. Really.');
}
```

### 유형 문제

```
let arg = prompt("Enter a value?");
switch (arg) {
  case '0':
  case '1':
    alert( 'One or zero' );
    break;

  case '2':
    alert( 'Two' );
    break;

  case 3:
    alert( 'Never executes!' );
    break;
  default:
    alert( 'An unknown value' );
}
```

프롬프트의 입력값은 문자열이기 때문에 이경우 3을 입력해도 실행되지 않는 데드코드를 가지고 있다.

# 숙제

## switch를 if로 다시 작성

ìf…else`로 다음 코드를 다시 작성해보자.

```
switch (browser) {
  case 'Edge':
    alert( "You've got the Edge!" );
    break;

  case 'Chrome':
  case 'Firefox':
  case 'Safari':
  case 'Opera':
    alert( 'Okay we support these browsers too' );
    break;

  default:
    alert( 'We hope that this page looks ok!' );
}
```

## `if`를 `switch`로 다시 작성

`switch`로 다시 작성해보자.

```
let a = +prompt('a?', '');

if (a == 0) {
  alert( 0 );
}
if (a == 1) {
  alert( 1 );
}

if (a == 2 || a == 3) {
  alert( '2,3' );
}
```
