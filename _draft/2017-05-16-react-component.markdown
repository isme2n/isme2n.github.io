---
layout: post
title:  "React Component - Stateless 또는 Stateful"
subtitle:   "React 컴포넌트를 만들다 고민이 생겼다."
categories:  til regex 
---

React 컴포넌트를 만들다 고민이 생겼다.

Stateless 컴포넌트를 만들까? Stateful 컴포넌트를 만들까?

제 경험으로 stateless 컴포넌트에 state가 생긴다는 건 주로 아래 두가지 상황이었습니다.

1) 기존 컴포넌트에 추가 기능이 생긴 것
2) 기존 컴포넌트에 고정값이 가변값으로 변경된 것

1)의 경우엔 별도 컴포넌트로 보아 아예 새로 컴포넌트를 생성하고
2)의 경우엔 기존 컴포넌트를 wrap하는 stateful한 컴포넌트를 생성합니다. (Presentational & Container 컴포넌트 패턴을 참고하셔요)