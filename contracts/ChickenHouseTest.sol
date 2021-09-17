pragma solidity ^0.5.2;
pragma experimental ABIEncoderV2;
import "./OrderRoomTest.sol";

// ChickenHouse 역할
contract ChickenHouseTest {
  OrderRoomTest[] orderRooms;

  string storeName;
  address owner;
  uint8 onOff;
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
  
 constructor (string memory _storeName, string memory _latitude, string memory _longitude) public {
          storeName = _storeName;
          latitude = _latitude;
          longitude = _longitude;
      }
  // 메뉴(치킨, 가격, state)등록
  function registerChickenHouse(string[] memory _chickenNames, uint256[] memory _prices ,uint256[] memory _menuState) public returns(uint256) {
       require(_chickenNames.length == _prices.length);

        for(uint i = 0 ; i <_chickenNames.length ; i++){
            menus.push( Menu(_chickenNames[i], _prices[i], _menuState[i],i));
        }
        return menus.length;    
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
          
      }
    

      
    
  // 주문방 만들기
  function createRoom(uint256 _price, uint256 _finish, string memory _chickenName, uint _valueToSend) public payable {
    // room 생성!!!!
    OrderRoomTest orderRoom = new OrderRoomTest(_price, _finish, _chickenName);
    orderRooms.push(orderRoom);
    // OrderRoomTest a = OrderRoomTest(address(uint160(address(orderRoom))));
    // a.blah.value(_valueToSend)(0,0);
    address(uint160(address(orderRoom))).transfer(_valueToSend);
    roomCount++;
  }

  function() external payable {}
  
      
   function matchRoom(uint256 _roomIndex) public payable {
    // 바로 할당을 위한 생성
    OrderRoomTest orderRoom = orderRooms[_roomIndex];
     address(uint160(address(orderRoom))).transfer(address(this).balance);
    orderRoom.matchRoom();
  }
  
  function approveOrder(uint256 _roomIndex) public {
    OrderRoomTest orderRoom = orderRooms[_roomIndex]; // 해당 치킨하우스에 해당하는 orderRoom을 찾는다.
    // require (tx.origin == owner);  
    orderRoom.approveOrder();
  }

  function getBalance(uint256 _roomIndex) public view returns (uint256) {
    OrderRoomTest orderRoom = orderRooms[_roomIndex];
    return address(orderRoom).balance;

  }

   function getStateRoom(uint256 _roomIndex) public view returns (uint256) {
    OrderRoomTest orderRoom = orderRooms[_roomIndex];
    return orderRoom.getStateRoom();

  }


  // 2. 원하는 치킨집의 정보를 가져온다?
  function getChickenHouse() public view returns (string memory, string memory, string memory, uint8){
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
   OrderRoomTest orderRoom = orderRooms[_roomIndex];
    return orderRoom.getRoomInfo();
  }

}
