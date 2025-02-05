require('dotenv').config();
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");

const { ALCHEMY_API_URL, PRIVATE_KEY, ETHERSCAN_API } = process.env;

module.exports = {
  solidity: "0.8.7",
  defaultNetwork: "rinkeby", // Deploy network rinkeby testnet or etherium mainnet
  networks: {
    hardhat: {},
    rinkeby: {
      url: ALCHEMY_API_URL,
      accounts: [`0x${PRIVATE_KEY}`]
    },
    ethereum: {
      chainId: 1,
      url: ALCHEMY_API_URL,
      accounts: [`0x${PRIVATE_KEY}`]
    },
  },
  etherscan: {
    apiKey: ETHERSCAN_API
  }
}