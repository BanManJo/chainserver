pragma solidity ^0.5.2;
pragma experimental ABIEncoderV2;

import "./ChickenHouseTest.sol";

// Admin 역할
contract AdminTest {
   
  ChickenHouseTest[] chickenHouses;

  function() external payable {}

  // ChickenHouse (메뉴와함께) 등록
  function registerChickenHouse(string memory _storeName, string[] memory _chickenNames, uint [] memory _prices) public {
    ChickenHouseTest chickenHouse = new ChickenHouseTest(_storeName);
    chickenHouse.registerChickenHouse(_chickenNames, _prices);
    // 인스턴스를 만들어 준것 ?
    chickenHouses.push(chickenHouse);
  }

  // 방만들기 함수
  function createRoom(uint256 _storeIndex, uint256 _price, uint256 _finish, string memory _chickenName) public payable {
    // chickenHouse를 찾자 storeName 으로!
    ChickenHouseTest chickenHouse = chickenHouses[_storeIndex];
    uint valueTosend = msg.value;
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
  function approveOrder(uint256 _storeIndex , uint256 _roomIndex) public {
    //여기는 해당되는 방을 찾기위해 _storeName으로 치킨집을 찾고 _roomNumber로 해당되는 방을 찾는다 
    ChickenHouseTest chickenHouse = chickenHouses[_storeIndex];
    chickenHouse.approveOrder(_roomIndex);
  }

 function getBalanceOfRoom(uint256 _storeIndex, uint256 _roomIndex)
    public
    view
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
    ChickenHouseTest chickenHouse = chickenHouses[_storeIndex];
    return chickenHouse.getStateRoom(_roomIndex);
  }

  // function getChickenHouse(string _storeName) public view returns(string[]) {
  //   // 치킨집 이름에 해당하는 것을 가져와야한다.
  //   // 지도를 클릭했을때 프론트에서 얻을 수 있는 정보는 치킨집 이름이라고 생각한다.
  //   for( i = 0 ; i < chickenHouses.length ; i++){
  //     if(chickenHouses[i].storeName == _storeName){
  //       ChickenHouseTest chickenHouse = chickenHouses[i];
  //       return chickenHouse.getChickenHouse();
  //     }
  //   } 
  // }

  // 1. 지도에 모든 치킨집을 나타내기 위해서 모든 치킨집의 정보를 가져올 get 함수가 필요하다?
    // function getChickenHouse() public view returns(ChickenHouseTest[] memory){
    //   return chickenHouses;
    // }


  // 2. 원하는 치킨집의 정보를 가져온다?
    function getChickenHouse1(uint256 _storeIndex) public view returns(string memory, string memory, string memory, uint8){
      ChickenHouseTest chickenHouse = chickenHouses[_storeIndex];
      return chickenHouse.getChickenHouse1();
    }

  // 2.5 원하는 치킨집의 메뉴를 가져온다?
    function getStoreMenu(uint256 _storeIndex) public view returns(string[] memory, uint256[] memory){
      ChickenHouseTest chickenHouse = chickenHouses[_storeIndex];
      return chickenHouse.getStoreMenu();
    }


  // 3. 원하는 주문방의 정보를 가져온다?
    function getRoomInfo(uint256 _storeIndex, uint256 _roomIndex) public view returns(string memory, uint256, uint8, address){
       ChickenHouseTest chickenHouse = chickenHouses[_storeIndex];
      return chickenHouse.getRoomInfo(_roomIndex);
    }
  
}
