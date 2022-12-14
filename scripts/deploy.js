const main = async () => {
  const [deployer] = await hre.ethers.getSigners();
  const accountBalance = await deployer.getBalance();

  console.log("Deploying contract with account:", deployer.address);
  console.log("Account balance:", accountBalance.toString());

  const waveContractFactory = await hre.ethers.getContractFactory(
    "WaveMePortal"
  );
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.001"),
  });
  await waveContract.deployed();

  console.log("WaveMePortal address: ", waveContract.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();

//command to deploy locally is: npx hardhat run scripts/deploy.js --network localhost
