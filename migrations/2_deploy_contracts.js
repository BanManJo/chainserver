const Demo = artifacts.require('Demo');
const AdminTest = artifacts.require('AdminTest');

module.exports = function (deployer) {
  deployer.deploy(Demo);
  deployer.deploy(AdminTest);
};
