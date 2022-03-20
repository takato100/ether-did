pragma solidity ^0.8.6;

contract EthereumDIDRegistry {

    mapping(address => address) public owners;

    // addr - some kind of classification - addr - uint(timestamp?)
    mapping(address => mapping(bytes32 => mapping(address => uint))) public delegates;
    
    // the block number when changes occured
    mapping(address => uint) public changed;
    
    // incremented when the sig is checked
    mapping(address => uint) public nonce;

    modifier onlyOwner(address identity, address actor){
        require ( actor == identityOwner(identity), "bad-actor!!!");
        _;
    }

    event DIDOwnerChanged(
        address indexed identity,
        address owner,
        uint previousChange
    );

    event DIDDelegateChanged(
        address indexed identity,
        byte32 name,
        bytes value,
        uint validTo,
        uint previousChange
    );



    function identityOwner(address identity) public view returns (address) {
        address owner = owners[identity];

        if ( owner != address(0x00)) {
            return owner;
        }

        return identity;
    }
    
    // sigの意味がよくわからん
    //v : for pubkey-recover
    //r,s = used to issue and verify sig

    // when the sig is valid => return the signer
    
    function checkSignature(address identity, uint sigV, bytes32 sigR, byter32 sigS. bites32 hash) internal returns(address) {

        // recovering signers pubkey
        address signer = ecrecover(hash, sigV, sigR, sigS);
        require(signer == identityOwner(identity), "bad owner!");
        nonce[signer]++;
        return signer;
    }

    // check the delegate if it is valid or not
    function validDelegate(address identity, byte32 delegateType, address delegate) public view return(bool) {
        //timestamp
        uint validity = delegates[identity][keccak256(abi.encode(delegateType))][delegate];
        return (validity > block.timestamp);
    }

    //changeowner for internal call
    function changeOwner(address identity, address actor, address newOwner) internal onlyOwner(identity, actor){
        owners[identity] = newOwner;
        emit DIDOwnerChanged(identity, newOwner, changed[identity]);
        changed[identity] = block.number;
    }

    //changeowner for public
    // msg.sender的な外部入力は、分けて記述したいのかな
    // use this in the below func
    // is 'public' appropriate??

    funtion changeOwner (address identiy, address newOwner) public {
        changeOwner(identity, msg.sender, newOwner);
    }

    //change owner signed
    / ownerが変わる時にもとownerのsigが必要
    function changeOwnerSigned() public {
        owner = identityOwner(identity);
        byte32 hash = keccak256(abi.encodePacked(bytes1(0x19), bytes1(0), this, nonce[owner], identity, "changeOwner", newOwner));
        
    }
