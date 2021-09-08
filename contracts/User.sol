pragma solidity ^0.5.2;

contract User {

    struct creatUser {
    string userId;
    uint256 userAccount; 
  }
    creatUser[] public users;

    function userIf(string memory _userId, uint256 _userAccount) public returns(bool) {
    creatUser memory newcreatUser;
    newcreatUser.userId = _userId;
    newcreatUser.userAccount = _userAccount;
    users.push(newcreatUser);
    return true;
  }
    
    function getUserIf(uint256 _userAccountId) public view returns(string memory userId) {
    creatUser memory userzz = users[_userAccountId];
    return (userzz.userId);
  }


}