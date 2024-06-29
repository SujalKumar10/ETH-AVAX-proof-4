// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    string items = "1.DEGEN NFT 2.DEGEN T-shirt 3.DEGEN Treasure Chest";

    constructor() ERC20("Degen", "DGN"){}

    mapping(address => uint) private chestLeft;

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function decimals()override public view virtual returns (uint8) {
        return 0;
    }

    function RedeemToken(uint choice, uint units) public {
        require(choice<=3 && choice>0, "This item is not in the list");
        if(choice==1){
            require(units*10 <= balanceOf(msg.sender),"Insufficient Tokens" );
            _burn(msg.sender, units*10);
        }
        else if(choice==2){
            require(units*50 <= balanceOf(msg.sender),"Insufficient Tokens" );
            _burn(msg.sender, units*50);
        }
        else if(choice==3){
            require(units*100 <= balanceOf(msg.sender),"Insufficient Tokens" );
            _burn(msg.sender, units*100);
            chestLeft[msg.sender] += units; 
        }
    }

    function burn(uint _value) public {
        _burn(msg.sender, _value);
    }

    function burnFrom(address _from, uint256 _value) public {
    address spender = _msgSender();
    _spendAllowance(_from, spender, _value);
    _burn(_from, _value);
    }

    function itemsList() external view returns(string memory){
        return items;
    }

    function checkBalance() external view returns(uint){
        return this.balanceOf(msg.sender);
    }

    function chestsRemains() external view returns(uint){
        return chestLeft[msg.sender];

    }

    function openTreasurechest() public returns(string memory){
        require(chestLeft[msg.sender] > 0, "you don't have any chest");
        chestLeft[msg.sender]--;
        return "you got a item";      
    }
}