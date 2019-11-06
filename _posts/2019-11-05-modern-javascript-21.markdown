---
layout: post
title: "[모던자바스크립트] 21. Mocha를 이용한 테스트"
subtitle: "modern javascript, Mocha를 이용한 테스트"
categories: devlog
tags: javascript
comments: true
---

> 이 글은 번역 및 정리 글입니다.
> 출처: javascript.info

# Mocha를 이용한 테스트

자동화 된 테스트는 실제 프로젝트에서도 널리 사용된다.

## 왜 테스트가 필요한가?

함수를 작성할 때 일반적으로 어떤 기능을 수행해야하는지 떠올리며 개발한다.

하지만 주먹구구식의 개발방식에는 문제가 있을 수 있다.

### 수동방식으로는 놓치는게 있을 수 있다.

예를 들어 `f(1)`함수가 잘 작동하고 `f(2)`가 잘 작동하지 않는다면, `f(2)`를 수정해서 확인하고 넘어가는게 맞는걸까? 정답은 `아니다`. 우리는 `f(1)`을 다시 확인해야 한다. 수정사항으로 인해 기존 결과가 달라졌을 수 있기때문이다. 이런 경우를 놓치고 가는경우가 많다.

우리는 자동화된 테스트를 별도로 작성하여 테스트를 확인할 필요가 있다.

## Behavior Driven Development (BDD)

BDD를 이해하기 위해 예제 개발 사례를 살펴 보자

### `pow`의 개발: 스펙

`pow(x, n)` 함수를 만들고 싶다고하자. 우리는 `n>=0`고 가정한다.

스펙을 정의해서 Mocha를 이용해 기술해 볼 수 있다. `test.js` 파일을 만들고 아래 구문을 작성하자.

```
describe("pow", function() {

  it("raises to n-th power", function() {
    assert.equal(pow(2, 3), 8);
  });

});
```

`describe("title", function() { ... })`

우리가 구현할 함수의 기능을 설명 하는 부분이다. `ìt`블록을 그룹화하는데에 사용된다.

`it("use case description", function() { ... })`

사람이 판독가능한 제목을 적어 용도를 설명하고, 테스트 함수를 작성한다.

`assert.equal(value1, value2)`

예상대로 작동하였는지 직접 확인하는 구문이다.

### 개발 흐름

1. 가장 기본적인 기능에 대한 테스트와 함께 초기 사양을 작성한다.
2. 초기 구현이 생성된다.
3. Mocha를 실행하여 오류를 확인한다. 모든 작동이 통과할때까지 수정한다.
4. 초기 구현을 완료했다.
5. 더 많은 유즈케이스를 스펙에 추가한다. 테스트가 실패하는경우가 생길 수 있다.
6. 3으로 이동하여 구현을 업데이트한다.
7. 온전히 함수가 준비될 때 까지 3-6을 반복한다.

기본적으로 반복적인 개발방법이다. 작은걸 완성하고 덩치를 부풀려나간다. 결국 우리는 동작하는 함수와 테스트를 모두 갖게 된다.

이 흐름을 따라 `pow`를 마저 개발해보자.

### 실제 사양

이 튜토리얼에서 사용하는 라이브러리는 아래와 같다.

- Mocha: 테스트기능을 제공하고 실행한다.
- Chai: 다양한 `assert`를 가지고 있는 라이브러리.

Node.js를 사용할수도 있고 브라우저에서도 가능하다. 이 예제에서는 브라우저에서 진행한다.

`mocha.html`을 만들고 아래 구문들을 작성하자.

```html
<!DOCTYPE html>
<html>
  <head>
    <!-- add mocha css, to show results -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/mocha/3.2.0/mocha.css"
    />
    <!-- add mocha framework code -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/mocha/3.2.0/mocha.js"></script>
    <script>
      mocha.setup("bdd"); // minimal setup
    </script>
    <!-- add chai -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/chai/3.5.0/chai.js"></script>
    <script>
      // chai has a lot of stuff, let's make assert global
      let assert = chai.assert;
    </script>
  </head>

  <body>
    <script>
      function pow(x, n) {
        /* function code is to be written, empty now */
      }
    </script>

    <!-- the script with tests (describe, it...) -->
    <script src="test.js"></script>

    <!-- the element with id="mocha" will contain test results -->
    <div id="mocha"></div>

    <!-- run tests! -->
    <script>
      mocha.run();
    </script>
  </body>
</html>
```

이 페이지는 다섯 부분으로 나눌 수 있다.

1. `<head>` - 테스트를 위해 타사 라이브러리과 스타일을 추가 할 수 있다.
2. `<script>` - 테스트를 위한 함수. 우리의 경우 `pow`
3. 테스트 - 우리의 경우 외부 스크립트 test.js에서 `describe("pow", ...)`를 한다.
4. HTML 요소 `<div id="mocha">`는 Mocha에서 결과를 출력하는 데 사용된다.
5. 테스트는 명령으로 시작된다 `mocha.run()`.

![](../assets/img/2019-11-05-18-14-06.png)

실행결과는 현재 이와같다. 테스트에 실패한것이다. 우리는 `8`을 기대한다고 테스트파일을 작성했지만 실제로는 `undefined`가 반환되어 실패하는것이다.

html코드에서 `pow`를 이렇게 작성해보자.

```js
function pow(x, n) {
  return 8; // :) 사기를 쳐보자!
}
```

![](../assets/img/2019-11-05-18-17-03.png)

통과했다!!!

### 사양개선

지금 우리가 작업한 코드는 분명한 속임수이다. 실제 우리가 원하는것처럼 작동하진 않을것이다.

`pow(3, 4)` 일 때도 검증하도록 해보자.

두가지 방법중 하나를 택할 수 있다.

#### assert를 추가

```js
describe("pow", function() {
  it("raises to n-th power", function() {
    assert.equal(pow(2, 3), 8);
    assert.equal(pow(3, 4), 81);
  });
});
```

#### 테스트를 하나 더 만들기

```js
describe("pow", function() {
  it("2 의 3 승은 8", function() {
    assert.equal(pow(2, 3), 8);
  });

  it("3 의 4 승은 81", function() {
    assert.equal(pow(3, 4), 81);
  });
});
```

주요 차이점은 `assert` 오류가 발생하면 `it`블록이 종료된다는 것이다. 따라서 1번 케이스에서 첫번째 `assert`가 실패하면 두번째는 표시되지 않는다.

테스트를 분리하는건 다양한 결과를 받아보기 좋으므로 두번째 방법이 일반적으로 더 좋다.

> 한 번의 테스트로 한 가지를 확인하자.

두 번째 방법으로 `test.js`에 작성하고 테스트해보자.

![](../assets/img/2019-11-05-18-28-05.png)

실패했다.

### 구현 개선

테스트가 통과할 수 있도록 좀 더 실제적인 코드를 짜보자.

```js
function pow(x, n) {
  let result = 1;

  // 제대로
  for (let i = 0; i < n; i++) {
    result *= x;
  }

  return result;
}
```

함수가 제대로 작동하는지 확인하기 위해 더 많은 값을 테스트하자. `it` 블록을 수동으로 작성하는 대신 `for`문으로 작성할 수 있다.

```js
describe("pow", function() {
  function makeTest(x) {
    let expected = x * x * x;
    it(`${x} 의 3 승은 ${expected}`, function() {
      assert.equal(pow(x, 3), expected);
    });
  }

  for (let x = 1; x <= 5; x++) {
    makeTest(x);
  }
});
```

![](../assets/img/2019-11-05-18-35-31.png)

### 중첩 기술

더 많은 테스트를 추가할건데, 그전에 현재 테스트를 그룹화 해보자.

```js
describe("pow", function() {
  describe(" x ** 3 ", function() {
    function makeTest(x) {
      let expected = x * x * x;
      it(`${x} ** 3 = ${expected}`, function() {
        assert.equal(pow(x, 3), expected);
      });
    }

    for (let x = 1; x <= 5; x++) {
      makeTest(x);
    }
  });

  // ... 다양한 테스트들이 여기 추가 된다.
});
```

![](../assets/img/2019-11-05-18-39-26.png)

### 추가 함수들

테스트를 실행하기전/후에 실행하는 `before/after`, 모든 `it` 전/후에 실행되는 `beforeEach/afterEach`

```js
describe("test", function() {
  before(() => alert("Testing started – before all tests"));
  after(() => alert("Testing finished – after all tests"));

  beforeEach(() => alert("Before a test – enter a test"));
  afterEach(() => alert("After a test – exit a test"));

  it("test 1", () => alert(1));
  it("test 2", () => alert(2));
});
```

이렇게 작성했다면 아래의 순서로 작동된다.

```js
Testing started – before all tests (before)
Before a test – enter a test (beforeEach)
1
After a test – exit a test   (afterEach)
Before a test – enter a test (beforeEach)
2
After a test – exit a test   (afterEach)
Testing finished – after all tests (after)
```

### 스펙 확장

`pow`의 기본기능이 완료되었다. 첫번째 반복이 끝났고, 샴페인을 한잔하자.

...

다 마셨으면 이제 다시 작업을 시작해보자.

n이 양의 정수가 아니면 문제가 생길거고 그로인한 결과들을 테스트해보자.

```js
describe("pow", function() {
  // ...

  it("마이너스 n 의 결과는 NaN", function() {
    assert.isNaN(pow(2, -1));
  });

  it("정수가 아닌 n 의 결과는 NaN", function() {
    assert.isNaN(pow(2, 1.5));
  });
});
```

![](../assets/img/2019-11-05-18-58-32.png)

테스트가 통과하지 못하므로 몇가지 코드를 더 작성해야한다.

```js
function pow(x, n) {
  if (n < 0) return NaN;
  if (Math.round(n) != n) return NaN;

  let result = 1;

  for (let i = 0; i < n; i++) {
    result *= x;
  }

  return result;
}
```

### 여러가지 assert

assert.isNaN은 NaN을 확인한다.

Chai 에는 다음과 같은 다른 주장이 있다 .

- assert.equal(value1, value2)– 평등을 확인 value1 == value2.
- assert.strictEqual(value1, value2)– 엄격한 동등 점검 value1 === value2.
- assert.notEqual, assert.notStrictEqual– 위의 것과 반대로 점검.
- assert.isTrue(value) – value === true
- assert.isFalse(value) – value === false
- … 전체 목록은 문서에 있다.

# 숙제

## 테스트를 어떻게 고치는게 더 바람직할까?

아래 테스트를 어떻게 고치는게 더 바람직할까?

```js
it("Raises x to the power n", function() {
  let x = 5;

  let result = x;
  assert.equal(pow(x, 1), result);

  result *= x;
  assert.equal(pow(x, 2), result);

  result *= x;
  assert.equal(pow(x, 3), result);
});
```
