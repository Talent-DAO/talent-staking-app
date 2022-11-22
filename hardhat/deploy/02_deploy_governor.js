// deploy/00_deploy_governor.js

const hre = require("hardhat");

const localChainId = "31337";

module.exports = async ({ getNamedAccounts, deployments, getChainId }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  const chainId = await getChainId();

  const veTalentTokenContract = await hre.ethers.getContractFactory(
    "veTalentToken",
  );

  console.log("veTalentTokenContract", {
    veTalentTokenContract: { address: veTalentTokenContract.address },
  });

  const governorContract = await deploy("TDAOGovernorBravo", {
    from: deployer,
    args: [
      "0x3f15B8c6F9939879Cb030D6dd935348E57109637", // token address
      "0x3f15B8c6F9939879Cb030D6dd935348E57109637", // timelock address
    ],
    log: true,
  });

  // You don't want to verify on localhost
  try {
    if (chainId !== localChainId) {
      await run("verify:verify", {
        address: governorContract.address,
        contract: "contracts/TDAOGovernorBravo.sol:TDAOGovernorBravo",
        constructorArguments: [
          "0x3f15B8c6F9939879Cb030D6dd935348E57109637", // token address
          "0x3f15B8c6F9939879Cb030D6dd935348E57109637", // timelock address
        ],
      });
    }
  } catch (error) {
    console.error(error);
  }
};

module.exports.tags = ["TDAOGovernorBravo"];
