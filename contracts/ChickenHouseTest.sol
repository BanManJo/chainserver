pragma solidity ^0.5.2;
pragma experimental ABIEncoderV2;
import "./OrderRoomTest.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

// ChickenHouse 역할
contract ChickenHouseTest is Ownable {
  
  OrderRoomTest[] orderRooms;

  string storeName;
  uint8 onOff = 0;
  string latitude;
  string longitude;
  Menu[] public menus;
  uint256 roomCount = 0;


  

  struct Menu {
    string chickenName;
    uint256 price;
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
  function registerChickenHouse(string[] memory _chickenNames, uint256[] memory _prices) public returns(uint256) {
       require(_chickenNames.length == _prices.length);

        for(uint i = 0 ; i <_chickenNames.length ; i++){
            menus.push( Menu(_chickenNames[i], _prices[i]) );
        }
        return menus.length;    
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
      OrderRoomTest orderRoom = findOrderRoom(_roomIndex);
     address(uint160(address(orderRoom))).transfer(address(this).balance);
    orderRoom.matchRoom();
  }
  
  function approveOrder(uint256 _roomIndex) public onlyOwner {
    OrderRoomTest orderRoom = findOrderRoom(_roomIndex); 
    // require (tx.origin == owner);  
    orderRoom.approveOrder();
    
  }

  function getBalance(uint256 _roomIndex) public view returns (uint256) {
    OrderRoomTest orderRoom = findOrderRoom(_roomIndex);
    return address(orderRoom).balance;

  }

   function getStateRoom(uint256 _roomIndex) public view returns (uint256) {
    OrderRoomTest orderRoom = findOrderRoom(_roomIndex);
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

}
