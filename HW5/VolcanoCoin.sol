// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title VolcanoCoin
 * @dev Issues issues and manages 'VolcanoCoin'
 */
contract VolcanoCoin is Ownable {

    uint supply = 10000;

    struct Payment {
        address recipient;
        uint amount;
    }

    event SupplyIncrease(uint indexed amount);
    event Transfer(address indexed from, address indexed to, uint indexed amount);

    mapping(address => uint) public balances;
    mapping(address => Payment[]) public payments;


    /**
     * @dev Set contract deployer as owner and give them
     * the total supply of VolcanoCoin
     */
    constructor() {
        balances[owner()] = supply;
    }

    /**
     * @dev Return the total supply of VolcanoCoin
     * @return uint supply of VolcanoCoin
     */
    function getSupply() public view returns (uint) {
        return supply;
    }

    /**
     * @dev Increase the total supply by 1000 tonkens.
     */
    function increaseSupply() public onlyOwner {
        supply += 1000;
        emit SupplyIncrease(supply);
    }

    /**
     * @dev Transfer VolcanoCoin tokens from one address to another
     * @param recipient the recipient's address
     * @param amount the amount to transfer
     */
    function transferTo(address recipient, uint amount) public onlyOwner {
        require(amount > 0,"Amount must be > 0");
        require(amount <= balances[owner()], "Insufficient funds for transfer.");

        balances[owner()] -= amount;
        balances[recipient] += amount;
        payments[owner()].push(Payment({
            recipient: recipient,
            amount: amount
        }));
        emit Transfer(owner(), recipient, amount);
    }
}