// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

contract Keyboards {
    //enum to ensure we're always using supported values
	enum KeyboardKind { 
	  SixtyPercent, 
	  SeventyFivePercent,
      EightyPercent, 
	  Iso105 
	}

    //struct container to store 4 fields i.e. keyboard kind from above, 1 boolean, 1 string, and 1 account address
    struct Keyboard {
        KeyboardKind kind; 
        // ABS = false, PBT = true
        bool isPBT;
        // tailwind CSS framework filters to layer over
        string filter;
        // user who created the keyboard
        address owner;
    }

    event KeyboardCreated(
     Keyboard keyboard
    );

    event TipSent(
     address recipient,
     uint256 amount
    );

  Keyboard[] public createdKeyboards;

  function getKeyboards() view public returns(Keyboard[] memory) {
    return createdKeyboards;
  }

  //function create(string calldata _description) external {
  //  createdKeyboards.push(_description);
  //}

  function create(
  KeyboardKind _kind,
  bool _isPBT,
  string calldata _filter
 ) external {
  Keyboard memory newKeyboard = Keyboard({
    kind: _kind,
    isPBT: _isPBT,
    filter: _filter,
    owner: msg.sender
  });

  createdKeyboards.push(newKeyboard);
  emit KeyboardCreated(newKeyboard);
 }

 function tip(uint256 _index) external payable  {
  address payable owner = payable(createdKeyboards[_index].owner);
  owner.transfer(msg.value);
  emit TipSent(owner, msg.value);
 }

}