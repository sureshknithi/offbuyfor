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
		unit age;
	}

	Member[] public members;
	
	function _generateRandomDna(string _str) private view returns (uint) {
		uint rand = uint(keccak256(_str));
		return rand % dnaModulus;
	}

	function _createMember(uint _dna, string _fName, string _lName, uint _age) internal {
		uint id = members.push(Member(_dna, _fName, _lName, _age)) - 1;
		NewMember(id, _dna, _fName, _lName, _age);
	}

	function createRandomMember(string _fName, string _lName, unit _age) public {
		uint randDna = _generateRandomDna(_name);
		randDna = randDna - randDna % 100;
		_createMember(randDna, _fName, _lName, _age);
	}

}
