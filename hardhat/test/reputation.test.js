const hre = require("hardhat");
const { use, expect } = require("chai");
const { solidity } = require("ethereum-waffle");

use(solidity);

describe("TalentDAO Journal of Decentralized Work", function () {
  let reputationController;

  // quick fix to let gas reporter fetch data from gas station & coinmarketcap
  before((done) => {
    setTimeout(done, 2000);
  });

  describe("ReputationController", function () {
    it("Should deploy ReputationController", async function () {
      const [user] = await ethers.getSigners();
      const Contract = await hre.ethers.getContractFactory(
        "ReputationController",
      );
      reputationController = await Contract.deploy(user.address);
    });
  });

  describe("createNewUser()", function () {
    it("Should create a new user", async function () {
      const [user] = await ethers.getSigners();

      expect(reputationController.createNewUser(user.address))
        .to.emit(reputationController, "NewUser")
        .withArgs(user.address);
    });
  });
});
