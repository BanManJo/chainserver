const TransactionTest = artifacts.require("TransactionTest");
const OrderRoom = artifacts.require("OrderRoom");

// contract('TransactionTest', (accounts) => {
//   it('컨트랙트 배포후 이더 전송 테스트', async () => {
//     instance = await TransactionTest.deployed();
//     balance = await web3.eth.getBalance(instance.address); // instance.address : contract 주소
//     assert.equal(balance, '0');

//     await instance.sendToContract({ from: accounts[0], value: 10 });
//     const result = await instance.getBalanceOf.call();
//     console.log(`Contract Account Balance: ${result}`);
//     balance = await web3.eth.getBalance(instance.address);
//     assert.equal(balance, '10');
//   });
// });

contract("OrderRoom", (accounts) => {
  it("방만들기 동시에 방contract계좌 송금", async () => {
    instance = await OrderRoom.deployed();
    balance = await web3.eth.getBalance(instance.address); // instance.address : contract 주소

    await instance.createRoom("BBQ", "original", 1, 10, {
      from: accounts[0],
      value: 10,
    });
    balance = await web3.eth.getBalance(instance.address);
    assert.equal(balance, "10");

    await instance.orderComplete(0, { from: accounts[0], value: 10 });
    balance = await web3.eth.getBalance(instance.address);
    assert.equal(balance, "20");

    await instance.ownerFetch(0, 3);
    balance = await web3.eth.getBalance(instance.address);
    assert.equal(balance, "0");
  });
});
