// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.19;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyToken is IERC20 {
    string public symbol = "TKN";
    string public name = "Token";
    uint8 public decimals = 2;
    uint256 public _totalSupply;

    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;

    constructor() {
        _totalSupply = 1000000;
        balances[msg.sender] = _totalSupply;
    }

    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(
        address account
    ) external view override returns (uint256) {
        return balances[account];
    }

    function transfer(
        address to,
        uint256 value
    ) external override returns (bool) {
        require(value <= balances[msg.sender]);

        balances[msg.sender] -= value;
        balances[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function allowance(
        address owner,
        address spender
    ) external view override returns (uint256) {
        return allowed[owner][spender];
    }

    function approve(
        address spender,
        uint256 value
    ) external override returns (bool) {
        allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external override returns (bool) {
        require(value <= balances[msg.sender]);
        require(value <= allowed[from][msg.sender]);

        balances[from] -= value;
        allowed[from][msg.sender] -= value;
        balances[to] += value;
        emit Transfer(from, to, value);
        return true;
    }
}
