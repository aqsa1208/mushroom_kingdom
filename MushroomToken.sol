// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./node_modules/@openzeppelin/contracts/access/Ownable.sol";


contract Token is ERC721, Ownable{
    
    constructor(string memory name, string memory symbol)ERC721(name , symbol){

    }

    uint256 nextId = 0;
    uint256 fee = 0.001 ether;

    struct Mushroom{
        string name;
        uint256 head;
        uint256 body;
        uint256 color;
        uint256 id;
        uint8 level;
    }

    Mushroom[] public mushrooms;

    event NewMushroom(address indexed owner, uint256 id, uint256 head,uint256 body,uint256 color);

    //mapping( uint256 => Mushroom) private _tokenDetails;

    function _creatRandomHead() internal view returns(uint256){
        uint256 randomNum = uint256(keccak256(abi.encodePacked(block.timestamp,msg.sender)));
        uint256 head = (randomNum %3)+1;
        return head;
    }

    function _creatRandomBody() internal view returns(uint256){
        uint256 randomNum2 = uint256(keccak256(abi.encodePacked(block.timestamp,msg.sender)));
        uint256 body = (randomNum2 %3)+1;
        
        return body;
    }

    function _creatRandomColor() internal view returns(uint256){
        
        uint256 randomNum3 = uint256(keccak256(abi.encodePacked(block.timestamp,msg.sender)));
        uint256 color = (randomNum3 %7)+1;
        
        return color;
    }

    function updateFee(uint256 _fee) external onlyOwner(){
        fee = _fee;
    }

    function withdraw() external payable onlyOwner() {
        address payable _owner = payable(owner());
        _owner.transfer(address(this).balance);
    }


    function _creatMushroom(string memory _name) internal {
        uint256 randomHead = _creatRandomHead();
        uint256 randomBody = _creatRandomBody();
        uint256 randomColor = _creatRandomColor();
        Mushroom memory newMushroom = Mushroom(_name,randomHead,randomBody,randomColor,nextId,1);
        mushrooms.push(newMushroom);
        _safeMint(msg.sender, nextId);
        emit NewMushroom(msg.sender, nextId, randomHead,randomBody,randomColor);
        nextId++;
    }

    function creatRandomMushroom(string memory _name) public payable {
        require(msg.value >= fee,"The fee is not correct.");
        _creatMushroom(_name);
    }

    function pairNewMushroom(string memory name,uint256 head,uint256 body,uint256 color) public  {
        Mushroom memory newMushroom = Mushroom(name,head,body,color,nextId,1);
        mushrooms.push(newMushroom);
        _safeMint(msg.sender, nextId);
        emit NewMushroom(msg.sender, nextId, head,body,color);
        nextId++;
        //require(msg.value >= fee,"The fee is not correct.");
        //_creatMushroom(_name);
    }

    function buyNewMushroom(string memory name,uint256 head,uint256 body,uint256 color) public payable {
        require(msg.value >= fee,"The fee is not correct.");
        Mushroom memory newMushroom = Mushroom(name,head,body,color,nextId,1);
        mushrooms.push(newMushroom);
        _safeMint(msg.sender, nextId);
        emit NewMushroom(msg.sender, nextId, head,body,color);
        nextId++;
        //require(msg.value >= fee,"The fee is not correct.");
        //_creatMushroom(_name);
    }


    function getMushrooms() public view returns(Mushroom[] memory){
        return mushrooms;
    }

}