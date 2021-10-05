const Demo = artifacts.require("Demo");
const Admin = artifacts.require("Admin");

module.exports = function (deployer) {
  deployer.deploy(Demo);
  deployer.deploy(Admin);
};
