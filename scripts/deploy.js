const hre = require("hardhat");

async function main() {
    // Get our account (as deployer) to verify that a minimum wallet balance is available
    const [deployer] = await hre.ethers.getSigners();
    console.log(`Deploying contracts with the account: ${deployer.address}`);
    console.log(`Account balance: ${(await deployer.getBalance()).toString()}`);

    // Fetch the compiled contract using ethers.js
    const GadjahPixel = await hre.ethers.getContractFactory("GadjahPixel");

    // Start deployment, calling deploy() will returning a promise that resolves to a contract object
    const gadjahPixel = await GadjahPixel.deploy();
    console.log("Contract deployed to address:", gadjahPixel.address);
    const receipt = await gadjahPixel.deployTransaction.wait();

    // Smart contract gas fee deployment cost
    console.log("Gas used: ", receipt.gasUsed._hex);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    });
