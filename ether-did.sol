pragma solidity ^0.8.6;

contract EtherDIDRegistry {

    mapping(address => address) public owners;

    // what byte32?  delegateType (from the Event) whats this!!
    mapping(address => mapping(bytes32 => mapping(address => uint))) public delegates;
    mapping(address => uint) public chainged;
    
    // what nonce
    mapping(address => uint) public nonce;

    modifier onlyOwner(address identity, address actor) {
    }



    event DIDOwnerChanged(
        address indexed identity,
        address owner,
        uint previousChange
    );

    event DIDDelegateChanged(
        address indexed identity,
        bytes32 delegateType,
        address delegate,

        // what?
        uint validTo,
        uint previousChange
    );

    event DIDAttributeChanged(
        address indexed identity,
        bytes32 name,
        bytes value,
        uint validTo,
        uint previousChange
    );

    function identityOwner(address identity) public view returns (address) {
        return owners[identity];
    }

    function _checkSignature(address identity, uint8 V, bytes32 R, bytes32 S, bytes32 hash) internal view virtual {

    }
    }
}
