// deploy/00_deploy_reputation.js

require("@nomiclabs/hardhat-ethers");

const localChainId = "31337";

module.exports = async ({ getNamedAccounts, deployments, getChainId }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  const chainId = await getChainId();

  const reputationControllerContract = await deploy("ReputationController", {
    from: deployer,
    args: ["0x3f15B8c6F9939879Cb030D6dd935348E57109637"],
    log: true,
  });

  // You don't want to verify on localhost
  try {
    if (chainId !== localChainId) {
      await run("verify:verify", {
        address: reputationControllerContract.address,
        contract: "contracts/ReputationController.sol:ReputationController",
        constructorArguments: ["0x3f15B8c6F9939879Cb030D6dd935348E57109637"],
      });
    }
  } catch (error) {
    console.error(error);
  }
};

module.exports.tags = ["ReputationController"];
