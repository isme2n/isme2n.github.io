---
layout: post
title: "[모던자바스크립트] 5. 변수"
subtitle: "modern javascript, 변수"
categories: devlog
tags: javascript
comments: true
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# 변수

변수는 데이터가 저장되는 곳이다. 자바스크립트에서 변수를 작성하려면 `let`을 사용하면된다. 

```
let message;
```

이제 변수에 값을 할당 할 수 있다.

```
let message;
message = ‘Hello’;
```

변수는 이름으로 접근할 수 있다

```
let message;
message = ‘Hello’;

alert(message);
```

선언과 할당을 한줄로 결합 할 수 있다.


```
let message = ‘Hello’;

alert(message);
```

한 줄에 여러 변수를 선언할 수도 있다.

```
let user = 'John', age = 25, message = 'Hello';
```

하지만 가독성이 낮아 각각 한 줄을 사용하는걸 추천한다.

```
let user = 'John';
let age = 25;
let message = 'Hello';
```

이렇게도 사용한다.

```
let user = 'John',
  age = 25,
  message = 'Hello';
```

변수는 상자라고 생각할 수 있다. 상자에는 어떤 값이든 넣을 수 있고 값을 변경할 수도 있다.

```
let message;

message = 'Hello!';

message = 'World!'; // 값을 바꾼다

alert(message);
```

```
let hello = 'Hello world!';

let message;

// 'Hello world' 라는 값을 hello로부터 message에 넣는다
message = hello;

// 두 변수의 값은 같다.
alert(hello); // Hello world!
alert(message); // Hello world!

```

## 변수이름

자바스크립트는 변수의 이름을 지을 때 세가지 제약이 있다.

1. 문자, 숫자, 또는 `$`, `_`로 이루어져야한다.
2. 첫 문자는 숫자가 아니어야한다.
3. 예약 된 이름이 아니어야한다. (let, class, return, function 등)

```
let userName;
let test123;
```

일반적으로 이름에 여러 단어가 포함되어 있으면 camelCase(낙타 표기법)이 사용된다.

`myNewVariable`

```
let 1a; // 숫자로 시작할 수 없다.
let let; // 예약어는 사용할 수 없다.
let my-name; // 하이픈은 사용할 수 없다.
```

# 상수

상수를 선언하려면 `const`를 사용한다.

```
const myBirthday = ’09.17’
```

상수는 이름 그대로 항상 같은 수이기 때문에 변경될 수 없다.
```
const myBirthday = ’09.17;

myBirthday = '01.01'; // 에러 발생
```

## 대문자 상수

프로그램을 실행하기전에 미리 기억하기 어려운 값들을 상수로 사용하는 방법이 주로 사용된다.

이럴 때는 이름을 대문자와 밑줄을 사용하여 짓는다.

```
const COLOR_RED = "#F00";
const COLOR_GREEN = "#0F0";
const COLOR_BLUE = "#00F";
const COLOR_ORANGE = "#FF7F00";

let color = COLOR_ORANGE;
alert(color); // #FF7F00
```

이럴 때 장점은 

1. 값보다 이름이 외우기 쉽다.
2. 복잡한 값을 입력할때 오타, 오기 등을 방지할 수 있다.
3. 값의 의미를 이름으로 알 수 있다.

그럼 언제 대문자상수를 사용하고 언제 카멜케이스를 사용하나요?

변하지 않는 값(상수)에는 크게 두가지 종류가 있다.

1. 프로그램 시작 전에 알 수 있는 값(하드코딩 값)
2. 프로그램이 시작하고 나서야 알 수 있는 값

```
const startTime = new Date(); // 시작할 떄에 값을 배정하는 값이다.
```

## 이름 짓기

변수 이름을 잘 짓는건 개발을 하는데 아주 중요한 일 중에 하나이다.

큰 프로젝트에서는 수백, 수천의 변수가 사용되는데 의미가 모호하게 지어졌다면 변수의 근원부터 찾아야 할 것이다.

변수 명을 잘 짓는것으로 초보자와 숙련자의 코드를 구분 할 수 있다는 말도 있다.

변수를 선언하기 전에 올바른 이름인지 생각하는 습관을 들이자.

크게 확인해봐야할 사항은 다음과 같다.

- 읽기 쉽게 작성하라. `userName`, `shoppingCart`
- 약어를 피하라. `a`, `b`등의 이름은 무얼 의미하는지 모른다.
- 최대한 설명까지 포함하여라. `data`는 무슨 데이터인지 모른다. 
- 팀과 충분히 이야기하라. `currentUser`와 `currentVisitor`도 의도에 따라 다르게 사용 될 수 있다.

가능하다면 변수를 재사용하려하지 말아라. 

1. 코드를 최적화하는데 방해된다.
2. 오류가 났을 때 이 변수의 변화를 모두 추적해야한다. 디버깅 노력이 배로 든다.

# 숙제

## 변수 지어보기

1. `admin` 과 `name` 변수를 만들어라.
2.  `name`에 ”John”을 할당하라.
3. `admin`에 `name `의 값을 복사하라.
4. alert로 `admin`의 값을 확인하여라 (“John”이 나와야한다).

## 올바른 이름 짓기

1. 우리 행성의 이름으로 변수를 만들어라. 그러한 변수의 이름을 어떻게 지정 할 것인가?
2. 현재 방문자의 이름을 웹 사이트에 저장할 변수를 만들자. 해당 변수의 이름을 어떻게 지정 할 것인가?

## 대문자 const

```
const birthday = '18.04.1982';

const age = someCode(birthday);
``

어떤 것이 대문자 상수여야 좋을까? 둘다? Birthday? Age?

