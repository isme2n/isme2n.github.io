---
layout: post
title:  "[Google Extends I/O] Google AI Tech, Distributed Learning"
subtitle:   "Google AI Tech, Distributed Learning"
categories: review
tags: event

---

김준성 - 스켈터 랩

핑퐁 AI 리서치 팀

네이버 인턴 -> 스켈터랩

잡담 봇

오버뷰를 하려고 했음.

전 세션이랑 겹침

딘 선생님: `구글 AI는 전세계 최고의 AI 연구 기관입니다.`

구글 AI 1년간 약 1063개의 논문 발표

리서치 오버뷰를 해보자.

학습 방법과 모델들을 정리 해보자.

## NLP

### BERT

어떤 분야에 대해 모델의 이해를 높이면 해당 분야를 훨씬 빠르고 더 정확하게 학습한다는 것이 증명 되었음.

여러 모델에서 사용할 수 있는 기반 기술(모델)을 만드는 것이 중요한 연구주제

NLP의 트랜스퍼 러닝 히스토리 
- Word2Vec/Bag-of-Words
- 통계기반 Language Modeling
- ...
- ELMo: Deep Contextualized word representation
- 유니버셜 랭귀지 모델
- 버트
- ...
- XLNet

텍스트를 이해할 수 있도록 모델 시키지?

기존방법

이전 단어들을 주고 그 다음 단어 맞추기

버트

손흥민은 토트넘 최고의 공격수로 자리 잡았다.

빈칸 만들어가면서 학습

#### 트레인

프리트레이닝에는 위키피디아나 북코퍼스 처럼 대량의 텍스트 데이터 사용

Fine-Tuning Sub Task 실제 태스크에 대해서는 레이블링 된 데이터셋으로 Fine-Tuning(얼마 안걸림)

2018년 ML분야의 베스트 페이퍼로 인정.

버트를 학슶시키는 비용이 너무 커서 비판.

### Evolved Transformet

오토ML을 이용한 뉴럴 아키텍쳐 서치가 활발하게 연구됨

#### 노블 메소드

1. 트래이닝 한번 할 때 마다 오랜 학습이 필요
2. 랜덤 모델부터 서칭을 시작하면 스패이스가 너무 넓음
3. 트랜스폼...
4. ...

진화했다지만 거의 비슷하고 조금 다름

## Vision

### Self-Supervised Tracking via Video Colorization

비디오 오브젝트 트래킹.

오브젝트 트래킹하려면 픽셀단위의 레이블링이 필요했음. 

그러나 픽셀x시간(비디오) 단위의 래이블링은 너무 오래걸림.

레이블링 없이 대량의 동영상을 활용해서 할 수 있을까.

한프레임만 주고 학습 시킴

잘 됨.

결과는 기존 힘들었던 방법에 비해 조금 안좋은 정도.

앞으로 더 연구하겠다.

## Speech Generation

### Towards End-to-End Prosody Transfer for Expressive Speech Synthesis with Tacotron

단순히 음성만이 아니라. 감정에 의한 억양까지.

억양을 참고해서

문제는 같은 말을 억양만 다른걸로 가지고 있어야했음.

억양을 스타일로 인식하자.

### 번역

음성 - 텍스트 - 번역 텍스트 - 번역 음성

텍스트 변환 없이 음성 - 음성 번역 모델을 만들어보자.

인풋 스펙트로그램의 번역결과를 영어, 스페인어 음소로 생성하는 것도 같이학습

보이스와 텍스트간의 상관관계를 직/간접적으로 학습

그라운드 트루스(목표하는 성능)에 미치지는 못하지만 void to voice의 시작이라고 볼 수 있음.

## Speech Recognition

### 스트리밍 엔드 투 엔드 스피치 인식 포 모바일 디바이스

시리는 서버에 음성을 보냄. 음성을 서버로 보낼때 발생하는 레이턴시, 등등 문제 많음

RNN Rransducer

결과 음성인식 모델 20기가 정도인데 2기가로 줄임

빔서치를 이용해 싱글 뉴럴 네트워크 : 450메가

로우 프레치션/ 텐서플로 라이트 컴프레션: 80메가

4배빠르고 거의 동일한 성능

## 정리

세미, 셀프

엔드 투 엔드

온디바이스 모델

---

## AllReduce Distributed Learning

한성민(피그노즈) - 클로바 리서치 엔지니어

