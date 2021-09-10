pragma solidity 0.7.5;

import "./Ownable";

interface GovermentInterface {
    function addTransaction(address _from, address _to, uint _amount) external;
}

contract Bank is Ownable {
    GovermentInterface govermentInstance = GovermentInterface("fil with hash id of the contract deployed");
    mapping (address=>uint) balance;
    event balanceAdded(uint amount, address depositedTo);
    event depositDone(uint amount, address depositedTo);

    modifier costs(uint price) {
        require(msg.value >= price);
        _; // run the function
    }

    function addBalance(uint _toAdd) public onlyOwner returns (uint) {
        balance[msg.sender] += _toAdd;
        emit balanceAdded(_toAdd, msg.sender);
        return balance[msg.sender]; 
    }
    
    function deposit() public payable returns (uint)  {
        balance[msg.sender] += msg.value;
        emit depositDone(msg.value, msg.sender);
        return balance[msg.sender]; 
    }
    
    function withdraw(uint amount) public returns (uint) {
        // msg.sender is an address
        // address payable toSend = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
        // toSend.transfer(amount);
        require(balance[msg.sender] >= amount);
        balance[msg.sender] -= amount;
        msg.sender.transfer(amount);
        return balance[msg.sender];
    }

    function getBalance() view public returns (uint) {
        return balance[msg.sender];        
    }

    function transfer(address recipient, uint amount) public {
        // check balance of msg.sender
        require(balance[msg.sender] >= amount, "Balance not sufficient");
        require(msg.sender != recipient, "Don't transfer money to yourself");

        uint previousSenderBalance = balance[msg.sender];
        // transfer
        _transfer(msg.sender, recipient, amount);
        govermentInstance.addTransaction(msg.sender, recipient, amount);
        assert(balance[msg.sender] == previousSenderBalance - amount);
        // event logs and further checks
        
    }

    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }
}