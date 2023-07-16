// MIT License
//
//Copyright (c) 2023 bauti.eth
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

pragma circom 2.0.0;

include "mimcsponge.circom";

// Computes MiMC([left, right])
template HashLeftRight() {
    signal input left;
    signal input right;
    signal output hash;

    // @dev 220 seems to be the recommended value ?
    component hasher = MiMCSponge(2, 220, 1);
    hasher.ins[0] <== left;
    hasher.ins[1] <== right;
    hasher.k <== 0;
    hash <== hasher.outs[0];
}

// @dev leafCount = 2**levels
// @dev nodeCount = 2**(levels - 1)
template MerkleTreeLevel(leafCount, nodeCount) {
    signal input leaves[leafCount];
    signal output nodes[nodeCount];

    // check amounts are valid
    leafCount === 2*nodeCount;

    component hashers[nodeCount];

    var i = 0;
    var n = 0;
    while(i < nodeCount){
       hashers[i] = HashLeftRight();
       hashers[i].left <== leaves[n]; 
       hashers[i].right <== leaves[n + 1];
   
       nodes[i] <== hashers[i].hash;

       i++;
       n+=2;
    }
}


// @dev leafCount = 2**levels
// @dev result is sensitive to the order of leaves
template MerkleTree(levels){
    signal input leaves[2**levels];
    signal output root;

    component merkleLevels[levels]; 

    // @dev iterate over each level of the tree. 
    var i = 0;
    while(i < levels){
        var leafCount = 2**(levels - i);
        var nodeCount = 2**(levels - i - 1);

        merkleLevels[i] = MerkleTreeLevel(leafCount, nodeCount); 
    
        var n = 0;
        while(n < leafCount){
            merkleLevels[i].leaves[n] <== i == 0 ? leaves[n] : merkleLevels[i - 1].nodes[n];

            n++;
        }

        
        i++;
    }

    root <== merkleLevels[levels - 1].nodes[0];
}