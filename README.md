# DegenToken

## Description

DegenToken is an ERC20 token deployed on the Avalanche network. It is used within the Degen Gaming platform to reward players and allow them to redeem items in the in-game store.

## Features

- Minting: The owner can mint new tokens.
- Transferring: Players can transfer tokens to others.
- Redeeming: Players can redeem tokens for in-game items.
- Checking Balance: Players can check their token balance at any time.
- Burning: Players can burn tokens they no longer need.

## Content

### Functions

 1. mint: Allows the owner to mint new tokens.
    ```solidity
     function mint(address to, uint256 amount) public onlyOwner {
    _mint(to, amount);
    }
    
 2. RedeemTokens: Allows users to redeem tokens for specific items.
    ```solidity
     function RedeemToken(uint choice, uint units) public {
    require(choice <= 3 && choice > 0, "This item is not in the list");
    if (choice == 1) {
        require(units * 10 <= balanceOf(msg.sender), "Insufficient Tokens");
        _burn(msg.sender, units * 10);
    } else if (choice == 2) {
        require(units * 50 <= balanceOf(msg.sender), "Insufficient Tokens");
        _burn(msg.sender, units * 50);
    } else if (choice == 3) {
        require(units * 100 <= balanceOf(msg.sender), "Insufficient Tokens");
        _burn(msg.sender, units * 100);
        chestLeft[msg.sender] += units; 
    }
    }

 3. burn: Allows users to burn their tokens.
    ```solidity
     function burn(uint _value) public {
    _burn(msg.sender, _value);
    }

    function burnFrom(address _from, uint256 _value) public {
    address spender = _msgSender();
    _spendAllowance(_from, spender, _value);
    _burn(_from, _value);
    }
    
 4. CheckBalance: Allows users to check their token balance.
    ```solidity
     function checkBalance() external view returns (uint) {
    return this.balanceOf(msg.sender);
    }
    
 5. Treasure Chests: Allows users to check and open treasure chests.
    ```solidity
     function chestsRemains() external view returns (uint) {
    return chestLeft[msg.sender];
    }
 
    function openTreasurechest() public returns (string memory) {
    require(chestLeft[msg.sender] > 0, "you don't have any chest");
    chestLeft[msg.sender]--;
    return "you got an item";      
    }
    
### Variables

1. items: Lists all the items avilable in the store.
    ```solidity
     string items = "1.DEGEN NFT 2.DEGEN T-shirt 3.DEGEN Treasure Chest";

### Mapping

1. chestLeft: Count all the treasure chest available in the account.
    ```solidity
     mapping(address => uint) private chestLeft;



## Deployment
The contract is deployed on the Avalanche Fuji Testnet. Compatible wallet and test AVAX would be needed to ineract with this contract. 

## Remix

1. Open Remix.
2. Create a new file and paste the DegenToken contract code from contracts\DegenToken.sol.
3. Compile the contract using the Solidity compiler.
4. Switch to the "Deploy & Run Transactions" tab.
5. Select "Injected Provider - Wallet's name" as the environment to connect to your MetaMask wallet.
6. Ensure your wallet is set to the Avalanche Fuji Testnet.
7. Deploy the contract by selecting DegenToken from the contract dropdown and clicking "Deploy".
8. Confirm the transaction in MetaMask.

## Node js

1. Ensure you have Node.js and npm installed.
2. Clone this repository in navigate inside the folder:
   ```bash
   git clone https://github.com/AyushKr2003/AyushKr2003-ETH-AVAX-Building-on-Avalanche.git
   cd ETH-AVAX-Building-on-Avalanche
3. Install the necessary dependencies:
   ```bash
   npm i
4. Compile the contracts:
   ```bash
   npx hardhat compile
5. Add your private keys to a .env file:
   ```bash
   PRIVATE WALLET_PRIVATE_KEY = 
   PRIVATE SNOWTRACE_API_KEY = 
6. Run the deployment script:
   ```bash
   npx hardhat run scri

