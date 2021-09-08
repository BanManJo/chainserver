const TransactionTest = artifacts.require('TransactionTest');

contract('TransactionTest', (accounts) => {
  it('컨트랙트 배포후 이더 전송 테스트', async () => {
    instance = await TransactionTest.deployed();
    balance = await web3.eth.getBalance(instance.address); // instance.address : contract 주소
    assert.equal(balance, '0');

    await instance.sendToContract(id, { from: accounts[0], value: 10 });
    const result = await instance.getBalanceOf.call();
    console.log(`Contract Account Balance: ${result}`);
    balance = await web3.eth.getBalance(instance.address);
    assert.equal(balance, '10');
  });
});
