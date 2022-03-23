import Web3 from 'web3';
import lotteryJson from '@src/contract/lottery.json';
import erc20Json from '@src/contract/erc20.json';
import {ERC20_ADDRESS, BET_ADDRESS} from '@src/config/const.js';


var web3 = null;
if (window.ethereum) {
  web3 = new Web3(window.ethereum);
}

////////////////// ERC20, Lottery contract///////////////////
var lotteryContract;
var erc20Contract;
if (web3) {
  lotteryContract = new web3.eth.Contract(lotteryJson, BET_ADDRESS);
  erc20Contract = new web3.eth.Contract(erc20Json, ERC20_ADDRESS)
}
//////////////////Get ERC20 token balance///////////////
const minABI = [
  {
    constant: true,
    inputs: [{ name: '_owner', type: 'address' }],
    name: 'balanceOf',
    outputs: [{ name: 'balance', type: 'uint256' }],
    type: 'function'
  }
];

const contract = new web3.eth.Contract(minABI, ERC20_ADDRESS);
async function tokenBalance() {
  const walletAddress = (await window.ethereum.send('eth_requestAccounts')).result[0];
  console.log(walletAddress);
  const result = await contract.methods.balanceOf(walletAddress).call(); // 29803630997051883414242659
  const format = web3.utils.fromWei(result); // 29803630.997051883414242659
  return format;
}
////////////////////////////////////////////////////////////

export { erc20Contract,lotteryContract, tokenBalance };
