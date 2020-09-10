---
layout: post
title: 'React Hooks를 알아보자'
subtitle: '리액트 훅스를 알아보자'
categories: devlog
tags: javascript
comments: true
---

# React Hook

`함수 컴포넌트`에서 `React Lifecycle`을 `연동(hook into)`하는 함수. 이미 짜놓은 클래스 컴포넌트를 함수로 바꾸는건 권장되지 않는다. 리액트는 클래스 컴포넌트의 개발을 멈출 계획이 없다.

## Effect Hook

`useEffect`는 side-effects를 조절하는 함수로, 다른 컴포넌트에 영향을 끼칠 수 있는 렌더랑과정에서는 구현할 수 없는 작업들을 한다.

`componentDidMount` 나 `componentDidUpdate`, `componentWillUnmount`와 같은 목적으로 제공되지만, 하나의 API로 통합된 것이다.

```js
import React, { useState, useEffect } from 'react';

function Example() {
  const [count, setCount] = useState(0);

  // componentDidMount, componentDidUpdate와 비슷
  useEffect(() => {
    // 브라우저 API를 이용해 문서의 타이틀을 업데이트
    document.title = `You clicked ${count} times`;
  });

  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>
        Click me
      </button>
    </div>
  );
}
```

컴포넌트 안에 선언되어있기 때문에 `props`와 `state`에 접근할 수 있다. 기본적으로 React는 매 렌더링 이후에 effects를 실행한다.

리액트 컴포넌트에는 일반적으로 두 종류의 side effects가 있다. 정리(clean-up)가 필요한 것과 그렇지 않은 것. 

### 정리가 필요없는 것

네트워크 리퀘스트, DOM 수동 조작, 로깅 등은 정리(clean-up)가 필요 없는 경우들은 실행 이후 신경쓸 것이 없기때문에 정리가 필요없다.

`useEffect`는 렌더링과 이후의 모든 업데이트에서 매번 수행된다.

### 정리를 이용하는 Effects

외부 데이터를 구독해야하는 경우 메모리 누수가 발생하지 않도록 정리하는 것이 중요하다.

#### 성능최적화

특정 변수의 변화에서만 작동하여 성능을 높일 수 있다.

```js
useEffect(() => {
  document.title = `You clicked ${count} times`;
}, [count]); // count가 바뀔 때만 effect를 재실행합니다.
```

## useContext

```js
const themes = {
  light: {
    foreground: "#000000",
    background: "#eeeeee"
  },
  dark: {
    foreground: "#ffffff",
    background: "#222222"
  }
};

const ThemeContext = React.createContext(themes.light);

function App() {
  return (
    <ThemeContext.Provider value={themes.dark}>
      <Toolbar />
    </ThemeContext.Provider>
  );
}

function Toolbar(props) {
  return (
    <div>
      <ThemedButton />
    </div>
  );
}

function ThemedButton() {
  const theme = useContext(ThemeContext);
  return (
    <button style={{ background: theme.background, color: theme.foreground }}>
      I am styled by theme context!
    </button>
  );
}
```

`useContext`는 `Context.Provider`와 같이 사용하자.

## useReducer

`useState`의 대체 함수이다. 복잡한 로직을 가졌다면 `state` 보다는 리듀서가 사용되곤한다.

```js
const initialState = {count: 0};

function reducer(state, action) {
  switch (action.type) {
    case 'increment':
      return {count: state.count + 1};
    case 'decrement':
      return {count: state.count - 1};
    default:
      throw new Error();
  }
}

function Counter() {
  const [state, dispatch] = useReducer(reducer, initialState);
  return (
    <>
      Count: {state.count}
      <button onClick={() => dispatch({type: 'decrement'})}>-</button>
      <button onClick={() => dispatch({type: 'increment'})}>+</button>
    </>
  );
}
```

## useMemo

메모이제이션된 값을 반환한다.

`useMemo`는 의존성이 변경되었을 때에만 메모이제이션된 값만 다시 계산 한다. 이 최적화는 모든 렌더링 시의 고비용 계산을 방지하게 해준다.

배열이 없는 경우 매 렌더링 때마다 새 값을 계산하게 된다.

`useMemo`는 성능 최적화를 위해 사용할 수는 있지만 보장이 된다고 생각하지는 말자. 가까운 미래에 React에서는 이전 메모이제이션된 값들의 일부를 “잊어버리고” 다음 렌더링 시에 그것들을 재계산하는 방향을 택할지도 모른다. `useMemo`를 사용하지 않고도 동작할 수 있도록 코드를 작성하고 그것을 추가하여 성능을 최적화하라.

## useCallback

메모이제이션된 콜백을 반환한다. 

`useCallback(fn, deps)`은 `useMemo(() => fn, deps)`와 같다.

## useRef

`useRef`는 `.current` 프로퍼티로 전달된 인자로 초기화된 `ref` 객체를 반환한다.

```js
function TextInputWithFocusButton() {
  const inputEl = useRef(null);
  const onButtonClick = () => {
    // `current` points to the mounted text input element
    inputEl.current.focus();
  };
  return (
    <>
      <input ref={inputEl} type="text" />
      <button onClick={onButtonClick}>Focus the input</button>
    </>
  );
}
```

`useRef`는 내용이 변경될 때 그것을 알려주지는 않는다

## useImperativeHandle

`useImperativeHandle`는 부모 컴포넌트에 노출되는 인스턴스 값을 커스터마이즈한다. `forwardRef`와 더불어 사용하자.

```js
function FancyInput(props, ref) {
  const inputRef = useRef();
  useImperativeHandle(ref, () => ({
    focus: () => {
      inputRef.current.focus();
    }
  }));
  return <input ref={inputRef} ... />;
}
FancyInput = forwardRef(FancyInput);
```

## useLayoutEffect

`useEffect`와 같은 시그니쳐이며, 모든 DOM 변경 후에 동기적으로 발생한다.

## useDebugValue

React 개발자도구에서 사용자 Hook 레이블을 표시하는 데에 사용할 수 있다.

```js
function useFriendStatus(friendID) {
  const [isOnline, setIsOnline] = useState(null);

  // ...

  // Show a label in DevTools next to this Hook
  // e.g. "FriendStatus: Online"
  useDebugValue(isOnline ? 'Online' : 'Offline');

  return isOnline;
}
```

##  커스텀 훅

컨벤션이다. use를 앞에 붙이고 hook을 사용하면 커스텀 훅이라고 할 수 있다.

```js
import { useState, useEffect } from 'react';

function useFriendStatus(friendID) {
  const [isOnline, setIsOnline] = useState(null);

  useEffect(() => {
    function handleStatusChange(status) {
      setIsOnline(status.isOnline);
    }

    ChatAPI.subscribeToFriendStatus(friendID, handleStatusChange);
    return () => {
      ChatAPI.unsubscribeFromFriendStatus(friendID, handleStatusChange);
    };
  });

  return isOnline;
}

// 사용

function FriendStatus(props) {
  const isOnline = useFriendStatus(props.friend.id);

  if (isOnline === null) {
    return 'Loading...';
  }
  return isOnline ? 'Online' : 'Offline';
}
```