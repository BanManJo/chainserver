const Demo = artifacts.require("Demo");
// const OrderRoom = artifacts.require("OrderRoom");
// const ChickenHouse = artifacts.require("ChickenHouse");
// const User = artifacts.require("User");
// const Menu = artifacts.require("Menu");

module.exports = function (deployer) {
  deployer.deploy(Demo);
  // deployer.deploy(OrderRoom);
  // deployer.deploy(ChickenHouse);
  // deployer.deploy(User);
  // deployer.deploy(Menu);
};
