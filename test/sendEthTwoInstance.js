const AdminTest = artifacts.require("AdminTest");

contract("AdminTest", (accounts) => {
  it("방만들기 동시에 방contract계좌 송금 (인스턴스 admin -> chickenhouse -> orderroom)", async () => {
    instance = await AdminTest.deployed();

    // registerChickenHouse 함수 호출!
    await instance.registerChickenHouse();
    console.log("pass1");
    // createRoom 함수 호출!
    await instance.createRoom(0, { from: accounts[0], value: 10 });
    console.log("pass2");

    let balance = await instance.getBalanceOfRomm.call(0, 0); // instance.address : contract 주소
    console.log("pass3");
    assert.equal(balance, "10");
  });
});
