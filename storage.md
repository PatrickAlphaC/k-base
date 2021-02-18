# Storage Wars
[Skynet take](https://skynetwiki.tech/storage-chains-compared/)
[Another Take](https://medium.com/bitfwd/what-is-decentralised-storage-ipfs-filecoin-sia-storj-swarm-5509e476995f)
[Another Take](https://bravenewcoin.com/insights/the-future-of-data-storage-is-decentralized)

## Findings

## Stroj 

Upload through their centralized portal to a decentralized storage network. Not sure how centralized that is, but it *looks* like it's good. Seems like a compeititor to projects like Amazon S3, Google Cloud Platform Storage, etc. Does not appear to be a good solutions for a fully decentralized stack in web3. It looks like they are moving to more and more decentralized. At the moment their satellite nodes are centralized and to use their platform you have to sign up through their web portal. Uses STORJ as it's token, and is ETH based. 

All in in all, it *looks* like this is a good solution for cloud storage, but it isn't really decentralized yet, however the team appears to be making strides to do so. 

Tardigrade = Storj

## Sia / Skynet

PoW - uses similar methodology as filecoin. Makes nodes send proof that they have the data, they have contract agreements, redundancy is built in. 

Sia is to Filecoin as Skylinks is to IPFS.


## Filecoin

Adapted PoS. Incentive layer for IPFS - you create "agreements" with the Filecoin "lotus nodes" where the nodes agree to host your data. You can create multiple agreements with multiple lotus nodes to keep backups of the data and keep it decentralized. The Filecoin protocol issues challenges to make sure the sources are still holding the data. If not, they are heavily penalized. It can be built on top of IPFS or really any data storage. 

Is a decentralized solution. Not sure how much stuff costs at the moment. Works perfectly on top of Filecoin (well.... we'll see after I try it)

## IPFS

An open source protocol used to upload data. Anyone can host and upload data, and you can "pin" your data to have it persist. Pinning prevents important data from being deleted from your node when the clearing process happens (they have a garbage collector). Other nodes can pin (and host) your data, however their isn't really an incentive layer for them to do so. There are pinning services you can pay for redundancies on your data, and this would be the closest to a decentralized way. 

Great decentralized protocol, but doesn't have persistance built in. 

## Ceramic



## Neo

[Storj vs Neo](https://neospcc.medium.com/neofs-and-storj-comparison-efa426504cbb)
[Site](https://fs.neo.org/)
[GitHub](https://github.com/nspcc-dev)

Has it's own blockchain, and has a token. Looks like it's meant to integrate with the neo blockchain? 

Looks like it's a plugin for the [Neo blockchain](https://docs.neo.org/docs/en-us/index.html). Further research required, but after seeing it's original implementation in C#, unless their is a good use case, I'm all set. 

## Swarm

[Site](https://swarm.ethereum.org/)
Currently an MVP, Swarm was once incubated in the Ethereum Foundation

## 0Chain

Looks like it's currently a testnet? [betanet](http://one.devnet-0chain.net/)
PoS blockchain for data. Seems good. Only downside is scale. When dumping all your data into a blockchain, it gets big... fast. 
They do random challenges

## Arweave

[Github](https://github.com/ArweaveTeam/arweave)

Dump it all into a blockchain. Proof of Access Consensus. Not only does Arweave solve these issues with cryptography and decentralized architecture, but it serves a dual function acting as a platform for building decentralized apps (dApps). Has a token. 

(2) Proof of Access
Miners need not store all blocks. Unlike PoW, Arweave’s method doesn’t depend on the previous block only to validate transactions. Instead, it uses the previous block and a random block in the chain.

Blockweave is the name of the chain (sort of). It hashes the previous block, and a random one from the past.

Yellow paper quote: 
```
The recall block is selected based on a hash of the previous block and the
previous block’s height. This results in a deterministic but unpredictable
choice of block from the weave’s history.
```
Wtf - how is randomness in a determanistic system possible? 
If it's hashed with the previous block, why do you need to add a recall block? Maybe they just have the head block, this wouldn't be helpful because they'd have to replay the chain to get the data. Which is insane. The whole recall block is included in the hashing of the proof of work. 

The PoA algorithm also incentives miners to store ‘rare’ blocks more than it
incentivizes them to store well-replicated blocks. This is because when a rare
block is chosen, miners with access to it compete amongst a smaller number
of miners in the PoW puzzle for the same level of reward. As a consequence
of this, miners that prefer to store rarer blocks on average receive a greater
reward over time, all else being equal.



In the running:
- Skynet (PoW)
- Arweave (PoW)


No
0chain (sad)
IPFS (no incentive)
Filecoin (too early)
Storj
Ceramic (unclear incentives)

Easy:
Ceramic
- Incentive structure unclear
Skynet
- PoW (Yuck)
Raw IPFS
- No Incentives structure
Arweave
- PoW (meh)

Hard:
Filecoin
- Lotus node is f*cking massive

Not Decentralized (DQ):
Storj
