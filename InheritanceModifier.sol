pragma solidity 0.5.11;

import "./Owned.sol";

contract InheritanceModifier is Owned {
    mapping(address => uint) public tokenBalance;

   

    uint tokenPrice = 1 ether;

    constructor() public {
       
        tokenBalance[owner] = 100;
        
        }
    modifier onlyOwner() {
        require(msg.sender == owner, "you are not the owner");
            _;
    }
    function createNewToken() public onlyOwner {
        
        tokenBalance[owner]++;
    }

    function burnToken() public onlyOwner {
        
        tokenBalance[owner]--;
    }
    function purchaseToken() public payable {
        require((tokenBalance[owner] * tokenPrice) / msg.value > 0, "not enough tokens");
        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }
    function sendToken(address _to, uint _amount) public {
        require (tokenBalance[msg.sender] >= _amount, "not enough tokens");
        assert (tokenBalance[_to] + _amount >= tokenBalance[_to]);
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
    }
    
    }