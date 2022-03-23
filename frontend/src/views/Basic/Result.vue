<template>
  <div class="d-flex justify-content-center">
    <div>
      <button class="btn btn-primary mx-2" @click="registerPlayer()">registerPlayer</button>
      <button class="btn btn-primary mx-2" @click="getPlayersAddr">getPlayersAddr</button>
      <button class="btn btn-primary mx-2" @click="setTier">setTier</button>
      <button class="btn btn-primary mx-2" @click="getTier">getTier</button>
      <button class="btn btn-primary mx-2" @click="setERC20Token">setERC20Token</button>

      <button class="btn btn-primary mx-2" @click="placeBetAndRegisterGame(0)">PlaceBetAndRegisterGame</button>
      <button class="btn btn-primary mx-2" @click="getGamePlayers">getGamePlayers</button>

    </div>
      
  </div>
</template>

<script>
import { mapState } from 'vuex';
import web3 from 'web3'
import {
  erc20Contract,
  // tokenBalance,
  lotteryContract
} from '@src/web3/web3.js';
import {
  BET_ADDRESS,
ERC20_ADDRESS,
  CONTRACT_OWNER_ADDRESS
} from '@src/config/const.js'
export default {
  name: 'ResultComponent',
  data: () => {
    return {
      accounts: [],
      tier: [],
      approve:false
    };
  },
  computed: {
    ...mapState(['currentAccount'])
  },
  methods:{
    async registerPlayer(){
      await lotteryContract.methods.registerUser().send({from:this.currentAccount});
    },
    async getPlayersAddr(){
      var list = await lotteryContract.methods.getUserList().call()
      console.log(list)
    },
    async setTier(){
      console.log(web3.utils.toWei("200"))
      try{
        await lotteryContract.methods.setTier([web3.utils.toWei("1000"),web3.utils.toWei("1500"),web3.utils.toWei("2500"),web3.utils.toWei("4000"),web3.utils.toWei("8000"),web3.utils.toWei("10000")]).send({
          from:this.currentAccount
        })
        window.alert("Action Success!")
      }catch{
        window.alert('Action failed!')
      }
    },
    async getTier(){
      var list = await lotteryContract.methods.getTier().call()
      console.log(list)
    },
    async setERC20Token(){
      try{
        await lotteryContract.methods.setBetToken(ERC20_ADDRESS).send({from:CONTRACT_OWNER_ADDRESS})
      }catch{
        window.alert("Setting ERC20 token address failed!")
      }
    },

    async placeBetAndRegisterGame(val){
      await erc20Contract.methods.approve(BET_ADDRESS, web3.utils.toWei("1000")).send({from:this.currentAccount})
      console.log((await erc20Contract.methods.allowance(this.currentAccount, BET_ADDRESS).call()))
      await lotteryContract.methods.placeBetAndRegisterGame(val).send({from:this.currentAccount})
    }
    ,
    async getGamePlayers(){
      console.log((await lotteryContract.methods.getPlayerList().call()))
    }
  }
};
</script>
