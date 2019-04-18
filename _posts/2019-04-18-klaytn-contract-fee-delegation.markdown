---
layout: post
title:  "[Klaytn]클레이튼 컨트랙트 Fee 대납하기"
subtitle:   "클레이튼 컨트랙트 Fee 대납하기"
categories: devlog
tags: devlog javascript
---

클레이튼 네트워크의 사용료는 누군가가 대신 내어줄 수 있다. 서비스를 운영하는 주체가 된다면 이 기능에 대해서 고려할 텐데, 오늘은 간단한 구현체로 `클레이튼 네트워크에 등록된 컨트랙트의 함수를 대납으로 실행` 시켜보자.

## 구현체

```js
const encodedAbi = myContract.methods.myMethod(param).encodeABI();

const feeDelegator = async (from, fromPrivateKey, contractAddress, encodedAbi) => {
    const senderPrivateKey = fromPrivateKey;

    const { rawTransaction: senderRawTransaction } = await klaytn.accounts.signTransaction({
      type: FEE_DELEGATED_SMART_CONTRACT_EXECUTION_TYPE,
      from: from,
      to: contractAddress,
      data: encodedAbi,
      gas: GAS_LIMIT,
      value: 0,
    }, senderPrivateKey);

    const feePayerPrivateKey = FEE_DELEGATOR_PRIVATE_KEY;

    await klaytn.accounts.wallet.add(feePayerPrivateKey, FEE_DELEGATOR_ADDRESS);

    return await klaytn.sendTransaction({
      senderRawTransaction: senderRawTransaction,
      feePayer: FEE_DELEGATOR_ADDRESS,
    });
};
```

구현체는 위처럼하면 된다. 특별한 예외처리 없이 간단하게 감싸놓기만 했다. 여기서 중요한 점은 `signTransaction`의 `data`인자이다. `encodedABI`가 어떤 함수를 실행할건지와 어떤 인자를 지니고 있는지까지 포함하여 스마트 컨트랙트의 특정함수를 호출할 수 있다.

나머지는 상수와 변수이름으로 이해하기 쉽게 만들어 적어놨기 때문에 금방 이해가 될 것이다.