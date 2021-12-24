const AdminTest = artifacts.require("AdminTest");

contract("AdminTest", (accounts) => {
  it("방만들기 동시에 방contract계좌 송금 (인스턴스 admin -> chickenhouse -> orderoom)", async () => {
    instance = await AdminTest.deployed();

    // // 1. user1 방만들기 -> user2 주문 -> 사장 체결 과정 테스트
    // // registerChickenHouse 함수 호출!
    // await instance.registerChickenHouse(
    //   "다글다글",
    //   "위도",
    //   "경도",
    //   ["후라이드", "양념"],
    //   [3000, 4000],
    //   [0, 1]
    // );
    // console.log("pass1");

    // // createRoom 함수 호출!
    // await instance.createRoom("다글다글", 8000, 5, "뿌링클", {
    //   from: accounts[1],
    //   value: 1000000000000000000,
    // });
    // console.log("pass2");

    // let state = await instance.getStateRoom(0, 0);
    // console.log(state.toString());

    // let balance = await instance.getBalanceOfRoom.call(0, 0); // instance.address : contract 주소
    // console.log(balance);
    // console.log("pass3");
    // assert.equal(balance, "1000000000000000000");

    // // matchRoom 함수 호출!
    // await instance.matchRoom(0, 0, {
    //   from: accounts[2],
    //   value: 1000000000000000000,
    // });
    // balance = await instance.getBalanceOfRoom.call(0, 0);
    // console.log("pass4");
    // assert.equal(balance, "2000000000000000000");

    // //출금 함수 호출
    // await instance.approveOrder("다글다글", 0);
    // balance = await instance.getBalanceOfRoom.call(0, 0);
    // assert.equal(balance, "0");

    // // 2. user1 방만들기 -> 유효시간 초과시 user1 에게 환불 과정 테스트
    // // registerChickenHouse 함수 호출!
    // await instance.registerChickenHouse(
    //   "다글다글",
    //   "위도",
    //   "경도",
    //   ["후라이드", "양념"],
    //   [3000, 4000],
    //   [0, 1]
    // );
    // console.log("pass1");

    // // createRoom 함수 호출
    // await instance.createRoom("다글다글", 8000, 5, "뿌링클", {
    //   from: accounts[0],
    //   value: 1000000000000000000,
    // });
    // console.log("pass2");

    // let balance = await instance.getBalanceOfRoom.call(0, 0); // instance.address : contract 주소
    // console.log(balance);
    // console.log("pass3");
    // assert.equal(balance, "1000000000000000000");

    // //refund1 함수 호출
    // await instance.refund1("다글다글", 0);
    // console.log("pass4");
    // balance = await instance.getBalanceOfRoom.call(0, 0);
    // assert.equal(balance, "0");

    // 3. user1 방만들기 -> user2 주문 -> 사장님 승인 유효시간 초과시 user1 , user2 에게 환불 과정 테스트
    // registerChickenHouse 함수 호출!
    // await instance.registerChickenHouse(
    //   "다글다글",
    //   "위도",
    //   "경도",
    //   ["후라이드", "양념"],
    //   [3000, 4000],
    //   [0, 1]
    // );
    // console.log("pass1");

    // // createRoom 함수 호출
    // await instance.createRoom("다글다글", 8000, 5, "뿌링클", {
    //   from: accounts[2],
    //   value: 1000000000000000000,
    // });
    // console.log("pass2");

    // let balance = await instance.getBalanceOfRoom.call(0, 0); // instance.address : contract 주소
    // console.log(balance);
    // console.log("pass3");
    // assert.equal(balance, "1000000000000000000");

    // // matchRoom 함수 호출!
    // await instance.matchRoom(0, 0, {
    //   from: accounts[3],
    //   value: 1000000000000000000,
    // });
    // balance = await instance.getBalanceOfRoom.call(0, 0);
    // console.log("pass4");
    // assert.equal(balance, "2000000000000000000");

    // //refund2 함수 호출
    // await instance.refund2("다글다글", 0);
    // console.log("pass5");
    // balance = await instance.getBalanceOfRoom.call(0, 0);
    // assert.equal(balance, "0");
  });
});
