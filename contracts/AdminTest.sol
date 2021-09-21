pragma solidity ^0.5.2;
pragma experimental ABIEncoderV2;

import "./ChickenHouseTest.sol";

// Admin 역할
contract AdminTest {
   
  ChickenHouseTest[] chickenHouses;

  function() external payable {}
    
  mapping (string => uint) storeIndexs;
  
  //치킨집 배열에 길이를 반환하는 함수
  function getStoreReturn() public view returns(uint256) {
    // ChickenHouseTest chickenHouse = findChickenHouse(_storeName);
    return chickenHouses.length;
  }



  // 해당 치킨하우스를 찾는 함수
  function findChickenHouse(string memory _storeName) public view returns(ChickenHouseTest) {
        ChickenHouseTest chickenHouse = chickenHouses[storeIndexs[_storeName]];
        return chickenHouse;
  }


  // ChickenHouse (메뉴와함께) 등록
  function registerChickenHouse(string memory _storeName,string memory _latitude,string memory _longitude, string[] memory _chickenNames, uint256 [] memory _prices, uint256[] memory _menuState) public {
    if(chickenHouses.length ==  0){
        // require(msg.sender == 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c);
        ChickenHouseTest chickenHouse = new ChickenHouseTest(_storeName, _latitude, _longitude,  msg.sender);
    
        storeIndexs[_storeName] = chickenHouses.push(chickenHouse) - 1;
         chickenHouse.registerChickenHouse(_chickenNames, _prices, _menuState);
    }else{
    ChickenHouseTest chickenHouse = new ChickenHouseTest(_storeName, _latitude, _longitude,  msg.sender);
    
    storeIndexs[_storeName] = chickenHouses.push(chickenHouse) - 1;
    chickenHouse.registerChickenHouse(_chickenNames, _prices, _menuState);
    }    
    // 1 2 3 4 5 
  }
  //메뉴 인덱스 값의 치킨이름, 가격 , state(뼈1, 순살2) 수정 함수
   function setMenu(string memory _storeName, uint _index, string memory _chickenNames, uint256 _price, uint256 _menuState) public returns (bool) {
      ChickenHouseTest chickenHouse = findChickenHouse(_storeName);
        chickenHouse.setMenu(_index, _chickenNames, _price, _menuState);

      }
// 메뉴 인덱스 삭제 후 맨뒤에 인덱스 해당 삭제된 인덱스로 가져오기 함수
      function deleteMenu(string memory _storeName, uint256 _index) public returns (bool){
         ChickenHouseTest chickenHouse = findChickenHouse(_storeName);
          chickenHouse.deleteMenu(_index);
      }
  // 방만들기 함수
  function createRoom(string memory _storeName, uint256 _price, uint256 _finish, string memory _chickenName) public payable {
    // chickenHouse를 찾자 storeName 으로!
    ChickenHouseTest chickenHouse = findChickenHouse(_storeName);  
    // address(uint160(address(chickenHouse))).transfer(msg.value); // msg.value : 사용자가 전달한 이더
    chickenHouse.createRoom.value(msg.value)(_price, _finish, _chickenName);
  }
  
  // 방 Match 함수
 function matchRoom(string memory _storeName, uint256 _roomIndex) public payable {
    // 바로 할당을 위한 생성
    ChickenHouseTest chickenHouse = findChickenHouse(_storeName);
    address(uint160(address(chickenHouse))).transfer(msg.value);
    chickenHouse.matchRoom(_storeName, _roomIndex);
  }

  //가게 주인이 돈받는 함수
  function approveOrder(string memory _storeName , uint256 _roomIndex) public {
    //여기는 해당되는 방을 찾기위해 _storeName으로 치킨집을 찾고 _roomNumber로 해당되는 방을 찾는다 
    ChickenHouseTest chickenHouse = findChickenHouse(_storeName);
    chickenHouse.approveOrder(_storeName , _roomIndex);
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

  // 2. 원하는 치킨집의 정보를 치킨집 이름으로 가져온다?
    function getChickenHouse(string memory _storeName) public view returns(
      string memory storeName, 
      string memory latitude, 
      string memory longitude, 
      uint8 closed){
        ChickenHouseTest chickenHouse = findChickenHouse(_storeName);
        return chickenHouse.getChickenHouse();
    }

  // 2.2 원하는 치킨집의 정보를 인덱스로 가져온다?
    function getChickenHouse2(uint256 _storeIndex) public view returns(
      string memory storeName, 
      string memory latitude, 
      string memory longitude, 
      uint8 closed){
        ChickenHouseTest chickenHouse = chickenHouses[_storeIndex];
        return chickenHouse.getChickenHouse2();
    }


    // 2.5 원하는 치킨집의 메뉴를 가져온다?
    function getStoreMenu(string memory _storeName)
        public
        view
        returns (string[] memory, uint256[] memory)
    {
        ChickenHouseTest chickenHouse = chickenHouses[storeIndexs[_storeName]];
        return chickenHouse.getStoreMenu();
    }

  // 3. 원하는 주문방의 정보를 가져온다?
    function getRoomInfo(string memory _storeName, uint256 _roomIndex) public view returns(string memory, uint256, uint8, address){
        ChickenHouseTest chickenHouse = findChickenHouse(_storeName);
         return chickenHouse.getRoomInfo(_roomIndex);
    }
  

  // onOff 변경 함수
   function changeOnOff(string memory _storeName) public {
      ChickenHouseTest chickenHouse = findChickenHouse(_storeName);
          chickenHouse.changeOnOff();
   }

  // 하나의 메뉴를 추가하는 함수
   function addOneMenu(string memory _storeName, string memory _chickenName, uint256 _price, uint256 _menuState) public {
    ChickenHouseTest chickenHouse = findChickenHouse(_storeName);
    chickenHouse.addOneMenu(_chickenName, _price, _menuState);  
  }

  // 가게 이름을 수정하는 함수
  // function changeStoreName(string memory _storeName, string memory _changeName) public {
  //   ChickenHouseTest chickenHouse = findChickenHouse(_storeName);
  //     chickenHouse.changeStoreName(_changeName);
  // }

  // location 변경 함수
    function changeLocation(string memory _storeName, string memory _longitude, string memory _latitude) public {
      ChickenHouseTest chickenHouse = findChickenHouse(_storeName);
        chickenHouse.changeLocation(_longitude, _latitude);
    }

  // user1이 돈을 넣고 시간이 초과되었을때 환불되는 함수
    function refund1(string memory _storeName, uint256 _roomIndex) public {
      ChickenHouseTest chickenHouse = findChickenHouse(_storeName);
      chickenHouse.refund1(_roomIndex);
    }

  // user1과 user2 가 돈을 넣고 시간이 초과되었을때 환불되는 함수
    // function refund1(string memory _storeName, uint256 _roomIndex) public {
    //   ChickenHouseTest chickenHouse = findChickenHouse(_storeName);
    //   chickenHouse.refund1(_roomIndex);
    // }   

}
