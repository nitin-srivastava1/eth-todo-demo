// SPDX-License-Identifier: GPL-3.0 
pragma solidity >=0.4.22 <0.9.0; 
contract TodoList{
	
	struct Task
	{
		string task;
		bool isDone;
	}

	mapping (address => Task[]) private Users;
		
	// function to add a task
	function addTask(string calldata _task) external returns (string calldata)
	{
		Users[msg.sender].push(Task({
			task:_task,
			isDone:false
		}));
		return _task;
	}

	// function to get details of a task
	function getTask(uint _taskIndex) external view returns (Task memory)
	{
		Task storage task = Users[msg.sender][_taskIndex];
		return task;
	}

	// function to update status of a task
	function updateStatus(uint256 _taskIndex,bool _status) external
	{
		Users[msg.sender][_taskIndex].isDone = _status;
	}

	// function to delete a task
	function deleteTask(uint256 _taskIndex) external
	{
		// delete Users[msg.sender][_taskIndex];

		uint length = Users[msg.sender].length;
		require(_taskIndex < length);
		
		for(uint i = _taskIndex; i< length - 1; i++) {
			
			Users[msg.sender][i] = Users[msg.sender][i+1]; 
		}
		Users[msg.sender].pop();

		// delete Users[msg.sender][length-1];

	}

	// function to get task count.
	function getTaskCount() external view returns (uint256)
	{
		return Users[msg.sender].length;
	}
}
