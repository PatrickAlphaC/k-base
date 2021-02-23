# Where am I?

I'm currently testing to see if a string can be passed via a CL node. Run `pytest` and you'll see you're running into some issue. Please fix. You have a local CL node running on the kovan testnet. Run `chainlink node start` in the environments place to start. Also, you have to start up the ipfs external adapter. Ideally, write a bash script to set all this up for you. -Patrick 

Furthermore, you have confirmed, that the strings cannot be returned by the node. So now your task, is to find a workaround. 

Good luck. 

# K-BASE

Open Sourced Decentralized Living Community Run Documentation and Software Engineering Support

Front end: React
Blockchain: Eth (ideally Optimism for gas on L2)
Oracle: Chainlink
Database: IPFS

# Design

User comes to site. Types in a question, hits "enter".
THe FE sends a request to create the IPFS [FileCoin](https://proto.school/verifying-storage-on-filecoin/02)

Any questions? Join the Alpha Chain [Discord](https://discord.gg/g6Wfc297Yy)

## License

This project is licensed under the [MIT license](LICENSE).

Local IPFS API Call:

Host your `test.json` object on your IPFS node via the CLI:

```
ipfs add test/test.json
```

```
curl -X POST "http://127.0.0.1:5001/api/v0/block/get?arg=QmW2mDfeUfx6FtQWBQqG67NZTWPpvbPiQB7rvWYq4ZHQ46"
```

To view from the UI, you can do

```
ipfs files ls /
```

# TODO
1. Have someone ask a question (data posted to IPFS)
2. Have someone answer a question (answer posted to IPFS)
3. Main question can accept or deny
4. Give rep




k-base
how does rep work?

User joins, they have to stake rep to post a question and an answer. 


