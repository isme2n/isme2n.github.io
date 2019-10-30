---
layout: post
title: "[모던자바스크립트] 10. alert, prompt, confirm"
subtitle: "modern javascript, alert, prompt, confirm"
categories: devlog
tags: javascript
comments: true
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# alert, prompt, confirm

브라우저 기능중에 몇가지를 알아보자.

## alert

알러트는 메시지가 표시되고 `확인`을 누를때 까지 스크립트를 일시 중지한다.

```
alert(message);
```

## prompt

프롬프트는 사용자에게 입력을 받을 수 있다. 인자를 두개 받는다.

- title: 방문자에게 보여줄 텍스트.
- default: 선택적인 두 번째 매개 변수, 입력 필드의 초기 값.

```
let age = prompt('How old are you?', 100);

alert(`You are ${age} years old!`); // You are 100 years old!
```

## confirm

컨펌은 확인 및 취소 버튼이 달린 모달창을 표시한다.

```
let isBoss = confirm("Are you the boss?");

alert( isBoss ); // OK를 눌렀다면 true
```

# 숙제

## 간단한 페이지

이름을 요청하고 출력하는 웹 페이지를 작성하라.
