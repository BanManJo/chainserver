pragma solidity ^0.5.2;
pragma experimental ABIEncoderV2;
import "./OrderRoomTest.sol";
import "./Ownable.sol";

// ChickenHouse 역할
contract ChickenHouseTest is Ownable {
  
  OrderRoomTest[] orderRooms;

  string storeName;
  uint8 onOff = 0;
  string latitude;
  string longitude;
  Menu[] public menus;
  uint256 roomCount = 0;

  enum FreshJuiceSize{ SUNSAL, BBUE, LARGE }


  struct Menu {
    string chickenName;
    uint256 price;
    uint256 menuState;
    uint256 menuIndex;
  }
  
 constructor (string memory _storeName, string memory _latitude, string memory _longitude , address _owner) Ownable(_owner) public {
          storeName = _storeName;
          latitude = _latitude;
          longitude = _longitude;
      }

  function findOrderRoom(uint256 _roomIndex) public view returns(OrderRoomTest){
          OrderRoomTest orderRoom = orderRooms[_roomIndex];
          return orderRoom;
  }

  // 메뉴(치킨, 가격)등록
  function registerChickenHouse(string[] memory _chickenNames, uint256[] memory _prices, uint256[] memory _menuState) public {
       require(_chickenNames.length == _prices.length);

        for(uint i = 0 ; i <_chickenNames.length ; i++){
            menus.push(Menu(_chickenNames[i], _prices[i], _menuState[i], i));
        }
          
      }
      //메뉴 인덱스 값의 치킨이름, 가격 , state(뼈1, 순살2) 수정 함수
      function setMenu(uint _index, string memory _chickenNames, uint256 _price, uint256 _menuState) public returns (bool) {
          require(_index < menus.length);
          
          menus[_index].chickenName = _chickenNames;
          menus[_index].price = _price;
          menus[_index].menuState = _menuState;
      }
      // 메뉴 인덱스 삭제 후 맨뒤에 인덱스 해당 삭제된 인덱스로 가져오기 함수
      function deleteMenu(uint256 _index) public returns (bool){
          menus[_index] = menus[ menus.length-1];
          menus[_index].menuIndex = _index;
          delete menus[menus.length-1];
          menus.length--;
          
      }
    

      
    
  // 주문방 만들기
  function createRoom(uint256 _price, uint256 _finish, string memory _chickenName) public payable {
    // room 생성!!!!
    OrderRoomTest orderRoom = new OrderRoomTest(_price, _finish, _chickenName);
    orderRooms.push(orderRoom);
    // OrderRoomTest a = OrderRoomTest(address(uint160(address(orderRoom))));
    // a.blah.value(_valueToSend)(0,0);
    address(uint160(address(orderRoom))).transfer(msg.value);
    roomCount++;
  }

  function() external payable {}
  
      
   function matchRoom(string memory _chickenName, uint256 _roomIndex) public payable {
      OrderRoomTest orderRoom = findOrderRoom(_roomIndex);
     address(uint160(address(orderRoom))).transfer(msg.value);
    orderRoom.matchRoom(_chickenName, _roomIndex);
  }
  
  function approveOrder(string memory _chickenName, uint256 _roomIndex) public onlyOwner  {
    OrderRoomTest orderRoom = findOrderRoom(_roomIndex); 
    // require (tx.origin == owner);  
    orderRoom.approveOrder(_chickenName, _roomIndex);
  }

  function getBalance(uint256 _roomIndex) public view returns (uint256) {
    OrderRoomTest orderRoom = findOrderRoom(_roomIndex);
    return address(orderRoom).balance;

  }

   function getStateRoom(uint256 _roomIndex) public view returns (uint256) {
    OrderRoomTest orderRoom = findOrderRoom(_roomIndex);
    return orderRoom.getStateRoom();

  }


  // 2. 원하는 치킨집의 정보를 치킨집 이름으로 가져온다?
  function getChickenHouse() public view returns (string memory, string memory, string memory, uint8){
    return (storeName, latitude, longitude, onOff); 
  }
  
  // 2.2 원하는 치킨집의 정보를 인덱스로 가져온다?
  function getChickenHouse2() public view returns (string memory, string memory, string memory, uint8){
    return (storeName, latitude, longitude, onOff); 
  }


  // 2.5 원하는 치킨집의 메뉴를 가져온다?
  function getStoreMenu() public view returns(string[] memory, uint256[] memory){
    string[] memory chickenName = new string[](menus.length);
    uint256[] memory price = new uint256[](menus.length); 
    
    for(uint i = 0 ; i < menus.length; i++){
      chickenName[i] = menus[i].chickenName;
      price[i] = menus[i].price;
    }
    return (chickenName, price);
  }

  // 2.5 다른방법
    // function getStoreMenu2(uint256 _storeIndex) public view returns(Menu[] memory){
    //   return menus;
    // }


  // 3. 원하는 주문방의 정보를 가져오기
  function getRoomInfo(uint256 _roomIndex) public view returns (string memory, uint256, uint8, address){
   OrderRoomTest orderRoom = findOrderRoom(_roomIndex);
    return orderRoom.getRoomInfo();
  }

  // onOff 변경 함수
   function changeOnOff() public {
      if(onOff == 0){
        onOff = 1;
      }else if(onOff == 1){
        onOff = 0;
      }
   }

   // 하나의 메뉴를 추가하는 함수
      function addOneMenu(string memory _chickenName, uint256 _price, uint256 _menuState) public { 
         menus.push( Menu(_chickenName, _price, _menuState, menus.length - 1));

   }

  // 가게이름을 바꾸는 함수
  //  function changeStoreName(string memory _changeName) public {
  //    storeName = _changeName;
  //  }


  // location 변경 함수
   function changeLocation(string memory _longitude, string memory _latitude) public {     
     longitude = _longitude;
     latitude = _latitude;

   }
  
  // user1이 돈을 넣고 시간이 초과되었을때 환불되는 함수
    function refund1(uint256 _roomIndex) public {
      OrderRoomTest orderRoom = findOrderRoom(_roomIndex);
      orderRoom.refund1();
      roomCount--;
    }

  // user1과 user2 에게 환불
   function refund2(uint256 _roomIndex) public {
      OrderRoomTest orderRoom = findOrderRoom(_roomIndex);
      orderRoom.refund2();
      roomCount--;
    }  
    

   

}
