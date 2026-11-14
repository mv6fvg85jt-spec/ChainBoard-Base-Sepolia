// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title ChainBoard - a minimal on-chain guestbook for Base Sepolia demos
contract ChainBoard {
    struct Message {
        address author;
        uint64 timestamp;
        string content;
    }

    Message[] private messages;

    event MessagePosted(
        uint256 indexed messageId,
        address indexed author,
        uint64 timestamp,
        string content
    );

    function postMessage(string calldata content) external {
        uint256 length = bytes(content).length;
        require(length > 0, "Message cannot be empty");
        require(length <= 280, "Message too long");

        uint64 postedAt = uint64(block.timestamp);
        uint256 id = messages.length;
        messages.push(Message(msg.sender, postedAt, content));

        emit MessagePosted(id, msg.sender, postedAt, content);
    }

    function getMessageCount() external view returns (uint256) {
        return messages.length;
    }

    function getMessage(uint256 id)
        external
        view
        returns (address author, uint64 timestamp, string memory content)
    {
        require(id < messages.length, "Message does not exist");
        Message storage item = messages[id];
        return (item.author, item.timestamp, item.content);
    }
}
