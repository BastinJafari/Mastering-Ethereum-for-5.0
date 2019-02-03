pragma solidity ^0.5.00;

contract calledContract {
    event callEvent(address sender, address origin, address from);
    function calledFunction() public {
        emit callEvent(msg.sender, tx.origin, address(this));
    }
}

library calledLibrary {
    event callEvent(address sender, address origin,  address from);
    function calledFunction() public {
        emit callEvent(msg.sender, tx.origin, address(this));
    }
}

contract caller {
    function make_calls(calledContract _calledContract) public {
        // Calling calledContract and calledLibrary directly
        _calledContract.calledFunction();
        calledLibrary.calledFunction();

        // Low-level calls using the address object for calledContract

		bool success;
		bytes memory response;

		bytes memory functionSig = abi.encode(bytes4(keccak256("calledFunction()")));

		(success, response) = address(_calledContract).call(functionSig);
        require(success);

		(success, response) = address(_calledContract).delegatecall(functionSig);
		
        require(success);


    }
}
