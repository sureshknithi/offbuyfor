pragma solidity ^0.4.19;

import "./ownable.sol";
import "./safemath.sol";
import "./memberfactory.sol";
import "./groupfactory.sol";

contract Offbuyfor is Ownable {
	
	function joinGroup(uint _dna, uint _groupCode) public {
		Group storage g = getGroup(_groupCode);
		g.members[_dna] = getMember(_dna);
	}
	
	function leaveGroup(uint _dna, uint _groupCode) public {
		Group storage g = getGroup(_groupCode);
		delete g.members[_dna];
	}
	
}