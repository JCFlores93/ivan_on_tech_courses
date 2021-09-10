pragma solidity 0.7.5;

contract Goverment {
    struct Transaction {
        address from;
        address to;
        uint amount;
        uint txId;
    }

    Transaction[] transactionLog;

    function addTransaction(address _from, address _to, uint _amount) external {
        transactionLog.push(Transaction(_from, _to, _amount, transactionLog.length));
    }

    function getTransaction(uint _index) public view returns (address, address, uint) {
        Transaction transaction = transactionLog[_index]; 
        return (transaction.from, transaction.to, transaction.amount);
    }
}