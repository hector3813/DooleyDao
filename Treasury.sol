// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;


contract Treasury {
    address public dao;

    constructor(address _dao) {
        dao = _dao;
    }

    receive() external payable {} // Accept ETH deposits

    function withdraw(address payable _to, uint256 _amount) external {
        require(msg.sender == dao, "Only DAO can withdraw");
        _to.transfer(_amount);
    }
}
