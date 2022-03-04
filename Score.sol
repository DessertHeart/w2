// SPDX-License-Identifier: MIT
pragma solidity  >=0.7.0 <0.9.0;


contract Score {

    address public teacher;

    mapping(address => uint) public scoreTable;

    function addteacher(address _teacher) public {
        teacher = _teacher;
    }

    modifier onlyTeacher{
        require(tx.origin == teacher, "Oops, U r not a teacher!");
       _;
    }
    function modifyScore(address _student, uint _score) external onlyTeacher {
        require(_score <= 100, "score must be less than 100");
        scoreTable[_student] = _score;
    }
  
}

interface IScore {
     function modifyScore(address _student, uint _score) external; 
}


contract Teacher {

   address public teacherrecord = address(this);


   function modifyAsTeacher(IScore iscore, address _student, uint _score) public{
       iscore.modifyScore(_student, _score);
   }

}
