contract Ownable {
    address owner;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    constructor () {
        owner = msg.sender;
    }
}