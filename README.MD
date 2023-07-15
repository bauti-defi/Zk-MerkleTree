# Zk-MerkleTree

A circom circuit implementation of a Merkle Tree. There are two circuits: `Tree.circom` and `TreeChecker.circom`. The `Tree.circom` circuit takes an array of leaves and outputs `true` if the generated root is correct and `false` if it is not. The `TreeChecker.circom` circuit takes an array of leaves and a Merkle Tree root and outputs `true` if the root is valid and `false` if it is not.

---

### 🔍 Audits
This code is not audited and should be used for educational purposes only. **If you get wreck'd, it's not my fault.** ⚠️

To become an auditor, submit a PR with your name added to the list below and a link to your audit. All audits must be performed on the `master` branch.

**Audited By:**
-  ...

### ⚠️ Disclaimer 

This is my first serious attempt at creating a circom circuit. I'm sure there are many ways to improve this implementation. Please feel free to open an issue or PR if you have any suggestions. 

### 📚 Useful Resources 
- [Zk Programming Lecture](https://youtu.be/UpRSaG6iuks)
- [Zk Workshop - Intuition + Programming](https://www.youtube.com/watch?v=-2qHqfqPeR8&list=PLvvyxOd1rILerZHAs52Z36fyBBK1HHP8b)
- [zk-starter - Circom template repo](https://github.com/cawfree/zk-starter)
- [Tornado Cash](https://github.com/tornadocash/tornado-core/tree/master/circuits)
- [Circom Docs](https://docs.circom.io/getting-started/installation/)
- [Murky - Solidity merkle tree implementation](https://github.com/dmfxyz/murky/blob/main/src/common/MurkyBase.sol)
- [circomlib - Library circom circuit primitives](https://github.com/iden3/circomlib/tree/master)

### ✌️ License
MIT