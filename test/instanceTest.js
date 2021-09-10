const B = artifacts.require("B");

contract("B", (accounts) => {
  it("방만들기 동시에 방contract계좌 송금", async () => {
    instance = await B.deployed();
    let balance = await web3.eth.getBalance(instance.address); // instance.address : contract 주소

    // makeA 함수 호출!
    await instance.makeA();
    // makeA 함수 호출!
    await instance.makeA();
    // getABalanceIndexOf
    let result = await instance.getABalanceIndexOf.call(0);
    const A1 = result[1];
    // getABalanceIndexOf
    result = await instance.getABalanceIndexOf.call(1);
    const A2 = result[1];

    balance = await web3.eth.getBalance(instance.address);
    console.log(`B Contract balance: ${balance}`);

    const getBalance = await instance.getBalance({
      from: accounts[0],
      value: 100,
    });

    // console.log(getBalance);

    balance = await web3.eth.getBalance(instance.address);
    console.log(`B Contract balance: ${balance}`);

    balance = await web3.eth.getBalance(A1);
    console.log(`A1 balance: ${balance}`);
    await instance.transferTo(A1); // error!!! (contract 에서 A1 (contract instace)로 이더 보내기)

    balance = await web3.eth.getBalance(A1);
    console.log(`A1 balance: ${balance}`);

    assert.equal(balance, "10");
  });
});
