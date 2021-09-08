const Demo = artifacts.require('Demo');
const OrderRoom = artifacts.require('OrderRoom');
const ChickenHouse = artifacts.require('ChickenHouse');
const User = artifacts.require('User');
const Chicken = artifacts.require('Chicken');
const TransactionTest = artifacts.require('TransactionTest');

module.exports = function (deployer) {
  deployer.deploy(Demo);
  deployer.deploy(OrderRoom);
  deployer.deploy(ChickenHouse);
  deployer.deploy(User);
  deployer.deploy(Chicken);
  deployer.deploy(TransactionTest);
};
