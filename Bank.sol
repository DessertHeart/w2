// SPDX-License-Identifier: MIT
pragma solidity  >=0.7.0 <0.9.0;

contract Bank {
    // 方便查看，实际应private
    address public recipent;
    uint public totalcoins;

    mapping (address => uint) pendingWithdrawals;

    // 部署时转账ETH
    constructor() payable {
        recipent = msg.sender;
        totalcoins = msg.value;
    }

    // 合约接收转账
    receive() external payable {
        
        // 记录每个地址的转账金额
        pendingWithdrawals[msg.sender] = msg.value;
        
        totalcoins += msg.value;
    }

    function withdraw() public {
        uint amount = totalcoins;
        
        // 防止重入（re-entrancy）攻击
        totalcoins = 0;
        payable(msg.sender).transfer(amount);
    }
}

