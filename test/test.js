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

// contract("OrderRoom", (accounts) => {
//   it("방만들기 동시에 방contract계좌 송금", async () => {
//     instance = await OrderRoom.deployed();
//     balance = await web3.eth.getBalance(instance.address); // instance.address : contract 주소

//     await instance.createRoom("BBQ", "original", 1, 10, {
//       from: accounts[0],
//       value: 10,
//     });
//     balance = await web3.eth.getBalance(instance.address);
//     assert.equal(balance, "10");

//     await instance.orderComplete(0, { from: accounts[0], value: 10 });
//     balance = await web3.eth.getBalance(instance.address);
//     assert.equal(balance, "20");

//     await instance.ownerFetch(0, 3);
//     balance = await web3.eth.getBalance(instance.address);
//     assert.equal(balance, "0");
//   });
// });

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
