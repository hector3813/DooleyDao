// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DAOToken is ERC20 {
    address public admin;

    constructor() ERC20("DAO Governance Token", "DGT") {
        admin = msg.sender;
        _mint(msg.sender, 1000000 * 10**decimals()); // 1M initial supply
    }

    function mint(address to, uint256 amount) external {
        require(msg.sender == admin, "Only admin can mint");
        _mint(to, amount);
    }
}
