---
layout: post
title:  "Meteor에서 publish 제대로 하기"
subtitle:   "Meteor에서 publish할 때 조심해야 하는 경우가 있다."
categories: meteor dev
---

Meteor에서 publish할 때 조심해야 하는 경우가 있다.

보통의 경우 user정보를 항시 받을텐데, 이 때 users 콜렉션을 전부 publish한다면 문제가 된다.

아마 필요한 정보는 아이디, 프로필 사진정도 되는 정보일 텐데, 굳이 다 보낼 필요는 없다.

이 이슈는 보안에 관련한 이슈이기도 하다.

가능하면 publish할 때는 최소한의 정보만 보낼 수 있도록 설계하는 습관을 들이자.

가장 간단한 publish방법을 떠올리자면 아래와 같이 할 거다.

### 개선하기 전 publish

```js
Meteor.publish('userData', function () {
    return Meteor.users.find();
})
``` 

이렇게 하면 유저의 패스워드나 개인신상 정보가 함께 달려가기 때문에 위험하다.

필요한 정보만 쓰기 위한 방법은 아래와 같다.

### 개선한 publish

```js
Meteor.publish('userData', function () {
    return Meteor.users.find({},{ fields : { profile: 1}});
})
```

이렇게하면 profile에 해당하는 정보를 줄 수있다.

간단한 설정만으로 보안에도 신경쓴 코드가 되었다.