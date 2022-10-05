// const main = async () => {
//   const [owner, randomPerson] = await hre.ethers.getSigners();
//   const waveContractFactory = await hre.ethers.getContractFactory(
//     "WaveMePortal"
//   );
//   const waveContract = await waveContractFactory.deploy();
//   await waveContract.deployed();

//   console.log("Contract Deployed to:", waveContract.address);
//   console.log("Contract deployed by:", owner.address);

//   await waveContract.getTotalWaves();

//   const firstWaveTxn = await waveContract.wave();
//   await firstWaveTxn.wait();

//   await waveContract.getTotalWaves();

//   // For getting a wave from anyone other than you
//   const secondWaveTxn = await waveContract.connect(randomPerson).wave();
//   await secondWaveTxn.wait();

//   await waveContract.getTotalWaves();
// };

const main = async () => {
  const waveContractFactory = await hre.ethers.getContractFactory("WaveMePortal")
  const waveContract = await waveContractFactory.deploy();
  await waveContract.deployed();
  console.log("Contract address:", waveContract.address)

  let waveCount;
  waveCount = await waveContract.getTotalWaves();
  console.log(waveCount.toNumber())

  //Send a few waves
  let waveTxn = await waveContract.wave("Hello World!")
  await waveTxn.wait() // Wait for the transaction to be mined

  const[_, randomPerson] = await hre.ethers.getSigners();
  waveTxn = await waveContract.connect(randomPerson).wave("Another Hello World!")
  await waveTxn.wait() // Wait for the transaction to be mined

  let allWaves = await waveContract.getAllWaves()
  console.log(allWaves)
}

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
