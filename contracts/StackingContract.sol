// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin-solidity/contracts/utils/math/SafeMath.sol";


contract MetaToken is ERC20, Ownable {
    using SafeMath for uint256;
    address[] internal stakeholders;
    uint256 public rate = 1000;

    mapping(address => uint256) internal stakes;
    mapping(address => uint256) internal rewards;
    
   
    constructor() ERC20("MetaToken", "MTN") {
        _mint(msg.sender, 1000 * 10 ** 18);
    }

    function modifyTokenPrice(uint256 newRate) public onlyOwner {
        rate = newRate;
    }
    
    
    function buyToken(address buyer) public payable returns (uint256 amount) {
        require (msg.value > 0, "You need money for this transaction");
        amount = msg.value * rate;
        _mint(buyer, amount);
    }

    function isStakeholder(address stakeholder_address) public view returns(bool, uint256) {
        for (
            uint256 verified = 0;
            verified < stakeholders.length;
            verified += 1){
                if (stakeholder_address == stakeholders[verified]) return (true, verified);
            }
        return (false, 0);
    }

    function addStakeholder(address staker) public {
        (bool _isStakeholder, ) = isStakeholder(staker);
        if(!_isStakeholder) stakeholders.push(staker);
    }

    function removeStakeholder(address staker) public {
        (bool _isStakeholder, uint256 verified) = isStakeholder(staker);
        if(_isStakeholder){
            stakeholders[verified] = stakeholders[stakeholders.length - 1];
            stakeholders.pop();
        }
    }

    function viewStakeholder(address staker) public {
        (bool _isStakeholder,) = isStakeholder(staker);
        if(!_isStakeholder) stakeholders.push(staker);
    }

    
    function stakeOf(address staker) public view returns (uint256) {
        return stakes[staker];
    }


    function combinedStake() public view returns(uint256) {
        uint256 totalStakes = 0;
        for (
            uint256 verified = 0; 
            verified < stakeholders.length; 
            verified += 1){
                totalStakes = totalStakes.add(stakes[stakeholders[verified]]);
            }
        return totalStakes;
    }

    function createStake(address staker, uint256 _stake) public {
        _burn(staker, _stake);
        if(stakes[staker] == 0) addStakeholder(staker);
        stakes[staker] = stakes[staker].add(_stake);
    }


    function removeStake(address staker, uint256 _stake) public {
        stakes[staker] = stakes[staker].sub(_stake);
        if(stakes[staker] == 0) removeStakeholder(staker);
        _mint(staker, _stake);
    }

    
    function rewardOf(address staker) public view returns(uint256) {
        return rewards[staker];
    }

    function combinedRewards() public view returns(uint256) {
        uint256 totalRewards = 0;
        for (
            uint256 verified = 0; 
            verified < stakeholders.length; 
            verified += 1){
                totalRewards = totalRewards.add(rewards[stakeholders[verified]]);
            }
        return totalRewards;
    }


    
    function calculateReward(address staker) public view returns(uint256) {
        return stakes[staker] /100;
    }


  /*  function distributeRewards() public onlyOwner {
        for (
            uint256 verified = 0;
            verified < stakeholders.length;
            verified += 1){
                address stakeholder = stakeholders[verified];
                uint256 reward = calculateReward(stakeholder);
                rewards[stakeholder] = rewards[stakeholder].add(reward);
            }*/
        }