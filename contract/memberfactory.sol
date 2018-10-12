pragma solidity ^0.4.19;

import "./ownable.sol";
import "./safemath.sol";

contract MemberFactory is Ownable {

	using SafeMath for uint256;

	event NewMember(uint memberId, string name, uint dna);

	uint dnaDigits = 16;
	uint dnaModulus = 10 ** dnaDigits;

	struct Member {
		uint dna;
		string fName;
		string lName;
		uint age;
	}
	
	mapping (uint => Member) members;
	
	Member[] public memberAccts;
	
	function _generateRandomDna(string _str) private view returns (uint) {
		uint rand = uint(keccak256(_str));
		return rand % dnaModulus;
	}

	function _createMember(uint _dna, string _fName, string _lName, uint _age) internal {
		Member newMember = Member(_dna, _fName, _lName, _age);
		uint id = memberAccts.push(newMember) - 1;
		members[_dna] = newMember;
		NewMember(id, _dna, _fName, _lName, _age);
	}

	function createMember(string _fName, string _lName, uint _age) public {
		uint randDna = _generateRandomDna(_name);
		randDna = randDna - randDna % 100;
		_createMember(randDna, _fName, _lName, _age);
	}
	
	function getMember(uint _dna) view public {
		return members[_dna];
	}
	
	function getAllMembers() view public {
		return memberAccts;
	}

}
