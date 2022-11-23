const { ethers } = require("hardhat");
const { use, expect } = require("chai");
const { solidity } = require("ethereum-waffle");

use(solidity);

describe("Talent Token Tests", function () {
  let tokenContract;
  // quick fix to let gas reporter fetch data from gas station & coinmarketcap
  before((done) => {
    setTimeout(done, 2000);
  });

  describe("Talent Token", function () {
    it("Should deploy Talent Token", async function () {
      const Contract = await ethers.getContractFactory("TalentToken");
      tokenContract = await Contract.deploy(
        "0xA4ca1b15fE81F57cb2d3f686c7B13309906cd37B"
      );
    });
  });
});
