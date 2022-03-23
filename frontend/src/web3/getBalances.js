import web3 from './web3';


// const provider =
//   "<YOUR_QUIKNODE_HTTP_PROVIDER_HERE>"

// const Web3Client = new Web3(new Web3.providers.HttpProvider(provider));

// The minimum ABI required to get the ERC20 Token balance
const minABI = [
  // balanceOf
  {
    constant: true,
    inputs: [{ name: "_owner", type: "address" }],
    name: "balanceOf",
    outputs: [{ name: "balance", type: "uint256" }],
    type: "function",
  },
];
const tokenAddress = "0xaf792cc1c299bc9c3d756be0ce17342b96988b05";
const walletAddress = "0x0d13BBACC78a48c3fC125Db396ACD0Cc75d1bfcd";

const contract = new web3.eth.Contract(minABI, tokenAddress);
export async function tokenBalance(){
  const result = await contract.methods.balanceOf(walletAddress).call(); // 29803630997051883414242659
  
  const format = web3.utils.fromWei(result); // 29803630.997051883414242659
    return format
//   console.log(format);
}

// export const tokenBalance = getBalance()

