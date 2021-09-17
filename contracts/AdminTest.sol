pragma solidity ^0.5.2;

import "./ChickenHouseTest.sol";

// Admin 역할
contract AdminTest {
   
  ChickenHouseTest[] chickenHouses;

  function() external payable {}

  // ChickenHouse 등록
  function registerChickenHouse() public {
    ChickenHouseTest chickenHouse = new ChickenHouseTest(msg.sender);
    chickenHouses.push(chickenHouse);
  }

  // 방만들기 함수
  function createRoom(uint256 _storeIndex, uint256 _price, uint256 _finish, string memory _chickenName) public payable {
    // chickenHouse를 찾자 storeName 으로!
    ChickenHouseTest chickenHouse = chickenHouses[_storeIndex];
    address(uint160(address(chickenHouse))).transfer(msg.value); // msg.value : 사용자가 전달한 이더
    chickenHouse.createRoom(_price, _finish, _chickenName);
  }
  
  // 방 Match 함수
 function matchRoom(uint256 _storeIndex, uint256 _roomIndex) public payable {
    // 바로 할당을 위한 생성
    ChickenHouseTest chickenHouse = chickenHouses[_storeIndex];
    address(uint160(address(chickenHouse))).transfer(msg.value);
    chickenHouse.matchRoom(_roomIndex);
  }

  //가게 주인이 돈받는 함수
  function approveOrder(uint256 _storeIndex , uint256 _roomIndex) public payable {
    //여기는 해당되는 방을 찾기위해 _storeName으로 치킨집을 찾고 _roomNumber로 해당되는 방을 찾는다 
    ChickenHouseTest chickenHouse = chickenHouses[_storeIndex];
    chickenHouse.approveOrder(_roomIndex);
  }

 function getBalanceOfRoom(uint256 _storeIndex, uint256 _roomIndex) public view
    returns (uint256)
  {
    ChickenHouseTest chickenHouse = chickenHouses[_storeIndex];
    return chickenHouse.getBalance(_roomIndex);
  }

  function getStateRoom(uint256 _storeIndex, uint256 _roomIndex)
    public
    view
    returns (uint256)
  {
    return 0;
    //ChickenHouseTest chickenHouse = chickenHouses[_storeIndex];
    //return chickenHouse.getStateRoom(_roomIndex);
  }
  
}
