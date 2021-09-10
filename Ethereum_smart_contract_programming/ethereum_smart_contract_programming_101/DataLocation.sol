pragma solidity 0.7.5;

contract DataLocation { 

    //storage: permanent over time and executions, persistant data storage
    // memory:  temporary data storage
    // calldata: similar to memory, but READ-ONLY, a lot less gas.

    // state variables
    uint data = 123; // stored in storage
    string lastText = "Hello Filip";

    function getString(string memory text, uint number) public {
        string memory newString = lastText;
        newString = text;   
    }
}