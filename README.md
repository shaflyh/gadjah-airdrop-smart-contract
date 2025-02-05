# Gadjah Airdrop Smart Contract

## 1. Installation

```shell
npm install
```

## 2. Edit your contract
Edit your smart contract according to your needs.

## 2. Create .env file
Create .env file in root folder. This file contain:

```shell
PUBLIC_KEY = "YOUR_PUBLIC_KEY" # Deployer wallet address
PRIVATE_KEY = "YOUR_PRIVATE_KEY"  # Deployer wallet private key
ALCHEMY_API_URL = "https://eth-rinkeby.alchemyapi.io/v2/....." # Get from alchemy
```

## 3. Edit hardhat.config.js and deploy.js
Add etherscan API in hardhat.config.js\
Change contract name in deploy.js

## 4. Compile and Deploy
```shell
#Compile to create ABI file in artifacts/contracts
npx hardhat compile

# Deploy to rinkeby testnet
npx hardhat run scripts/deploy.js --network rinkeby 

# Verify smart contract on etherscan
npx hardhat verify --network rinkeby CONTRACT_ADDRESS 

# If have arguments
npx hardhat verify --network rinkeby 0xf3f2E8EAf807df3eb3A48148435627BEC1A52ccc "ipfs://QmcomKLqJQPJDZMJrmbPnmK8fspUwT9t6W9cSDPHfn4UWS/"

npx hardhat verify --constructor-args scripts/arguments.js DEPLOYED_CONTRACT_ADDRESS

```

## Helpful links
[Hardhat](https://hardhat.org/getting-started/)\
[Opensea](https://docs.opensea.io/docs/getting-started-1)\
[Alchemy](https://docs.alchemy.com/alchemy/tutorials/how-to-create-an-nft)
