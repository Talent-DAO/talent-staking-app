const hre = require("hardhat");
const { use, expect } = require("chai");
const { solidity } = require("ethereum-waffle");

use(solidity);

describe("Talent DAO Governor Contract", function () {
  let governorBravoContract;

  // quick fix to let gas reporter fetch data from gas station & coinmarketcap
  before((done) => {
    setTimeout(done, 2000);
  });

  describe("Governor Contract", function () {
    it("Should deploy TDAOGovernorBravo", async function () {
      const [user] = await hre.ethers.getSigners();

      // Deploy the veTalent token contract
      const Token = await hre.ethers.getContractFactory("veTalentToken");
      const TokenContract = await Token.deploy(user.address);

      // Deploy the Lock contract
      const Lock = await hre.ethers.getContractFactory("Lock");
      // Nov-23-2022 01:20:23 AM +UTC --> convert to unix timestamp for argument of a time in the future
      const LockContract = await Lock.deploy(1670184488, TokenContract.address);

      // Deploy the Governor contract
      const Contract = await hre.ethers.getContractFactory("TDAOGovernorBravo");
      governorBravoContract = await Contract.deploy(
        TokenContract.address,
        LockContract.address,
      );
    });
  });
});
