const AdminTest = artifacts.require("AdminTest");

contract("AdminTest", (accounts) => {
  it("방만들기 동시에 방contract계좌 송금 (인스턴스 admin -> chickenhouse -> orderoom)", async () => {
    instance = await AdminTest.deployed();

    // registerChickenHouse 함수 호출!
    await instance.registerChickenHouse();
    console.log("pass1");

    // createRoom 함수 호출!
    await instance.createRoom(0, 8000, 5, "뿌링클", {
      from: accounts[1],
      value: 1000000000000000000,
    });
    console.log("pass2");

    let state = await instance.getStateRoom(0, 0);
    console.log(state.toString());

    let balance = await instance.getBalanceOfRoom.call(0, 0); // instance.address : contract 주소
    console.log(balance);
    console.log("pass3");
    assert.equal(balance, "1000000000000000000");

    // matchRoom 함수 호출!
    await instance.matchRoom(0, 0, {
      from: accounts[2],
      value: 1000000000000000000,
    });
    balance = await instance.getBalanceOfRoom.call(0, 0);
    console.log("pass4");
    assert.equal(balance, "2000000000000000000");

    //출금 함수 호출
    await instance.approveOrder(0, 0);
    balance = await instance.getBalanceOfRoom.call(0, 0);
    assert.equal(balance, "0");
  });
});