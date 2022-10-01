//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0; 
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; //importing the chainlink oracle for real time data

library PriceConverter{
        function getPrice() internal view returns (uint256){
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e); // APi refernce for price of eth to usd
        (,int256 price,,,) = pricefeed.latestRoundData();
        return uint256(price*1e10);    // 10 because the conversion rate has 10 decimals. 
    }

    function ConverPrice(uint256 ethAmount) internal view returns (uint256){
        uint256 priceEth = getPrice();

        uint256 priceEthtoUsd = (priceEth * ethAmount )/1e18;

        return priceEthtoUsd;
    }
}
