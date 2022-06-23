pragma solidity 0.8.7;

import "./IERC20.sol";

contract SimpleVault {
    IERC20 public token;

    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    constructor(address _token) {

        token = IERC20(_token);
    }

        function deposit(uint _amount) external {

        uint shares;
        if (totalSupply == 0) {
            shares = _amount;
        } else {
            shares = (_amount * totalSupply) / token.balanceOf(address(this));
        }

        mint_shares(msg.sender, shares);
        token.transferFrom(msg.sender, address(this), _amount);
    }

        function withdraw(uint _shares) external {

        uint amount = (token.balanceOf(address(this)) * _shares) / totalSupply;
        burn_shares(msg.sender, _shares);
        token.transfer(msg.sender, amount);
    }

    function mint_shares(address _to, uint _shares) private {

        totalSupply += _shares;
        balanceOf[_to] += _shares;
    }

    function burn_shares(address _from, uint _shares) private {

        totalSupply -= _shares;
        balanceOf[_from] -= _shares;
    }



}
