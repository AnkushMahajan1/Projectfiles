//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import"./PriceConverter.sol";

contract FundMe{
    using PriceConverter for uint256; // importing library

    uint256 minUSD = 50 *1e18;
    address[] public funders;
    mapping(address => uint256) public AddresstoAmount;
    address public owner;

    constructor () {
        owner = msg.sender;
    }


    function fund() public payable{

        require(msg.value.ConverPrice() >= minUSD, "Garib bc"); // msg.value is a global keyword 
        funders.push(msg.sender);
        AddresstoAmount[msg.sender ] = msg.value;
    }

    function withdraw() public {
        for(uint funderindex = 0; funderindex < funders.length; funderindex++)
        {
            address resetfund = funders[funderindex];
           AddresstoAmount[resetfund] = 0;
        }
        //reset array
        funders= new address[](0);
  
        //transfer
        //msg.sender contains address hence payable typecast to convert in payable address
     /*   payable(msg.sender).transfer(address(this).balance); 
        //send
        bool sendstat = payable(msg.sender).send(address(this).balance); 
        require(sendstat, "Transaction failed");*/
        //call
        (bool stats,)= payable(msg.sender).call{value: address(this).balance}(""); 
        require(stats, "Transaction failed");
    }
 
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
} 
