import web3 from './web3';
import lotteryJson from '@src/contract/lottery.json'

var lotteryContract;
if (web3) {
    lotteryContract = new web3.eth.Contract(lotteryJson,'0x2915DBfE9348b1dF4372A806554c76A3973342AE');
}

export default lotteryContract;
