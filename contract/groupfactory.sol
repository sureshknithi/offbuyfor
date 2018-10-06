pragma solidity ^0.4.19;

import "./ownable.sol";
import "./safemath.sol";

contract GroupFactory is Ownable {

	using SafeMath for uint256;

	event NewGroup(uint groupId, string name, uint code);

	uint codeDigits = 16;
	uint codeModulus = 10 ** codeDigits;

	struct Group {
		string name;
		uint code;
	}
	
	mapping (uint => Group) groups;
	mapping (uint => address) public groupToOwner;

	uint[] public groupAccts;
	
	function _generateRandomCode(string _str) private view returns (uint) {
		uint rand = uint(keccak256(_str));
		return rand % codeModulus;
	}

	function _createGroup(string _name, uint _code) internal {
		var newGroup = Group(_name, _code);
		uint id = groupAccts.push(newGroup) - 1;
		groups[_code] = newGroup;
		groupToOwner[_code] = msg.sender;
		NewGroup(id, _name, _code);
	}

	function createGroup(string _name) public {
		uint randCode = _generateRandomCode(_name);
		randCode = randCode - randCode % 100;
		_createGroup(_name, randCode);
	}
	
	function getGroup(uint _code) view public {
		return groups[_code];
	}
	
	function getAllGroups(uint _code) view public {
		return groupAccts;
	}

}
