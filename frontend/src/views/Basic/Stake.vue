<template>
  <div class="d-flex justify-content-center mt-4 mx-2 flex-wrap">
    <button
      v-for="item in tier"
      :key="item"
      class="btn btn-success tier"
      @click="stake(item)"
    >
      $TOKEN{{ item }}
    </button>
    <button @click="transfer()"></button>
  </div>
</template>

<script>
import { mapState } from 'vuex';
import dotenv from 'dotenv';
dotenv.config()
import web3 from 'web3'
import {
  erc20Contract,
  tokenBalance,
  lotteryContract
} from '@src/web3/web3.js';
import {
  BET_ADDRESS,
// ERC20_ADDRESS
} from '@src/config/const.js'
export default {
  name: 'StakeComponent',
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
  async mounted() {
    console.log(this.currentAccount);
  },
  methods: {
    async transfer(){
              await lotteryContract.methods.placeBet(0).send({from:this.currentAccount})

    },
    async stake(val) {
      var stakeAmount = Number(val)
      console.log("stakeAmount ",stakeAmount)
      try{
        var walletTokenAmount = await tokenBalance();
      }catch{
        window.alert('Error while fetch token amounts in your wallet!')
      }
      console.log("walletTokenAmount ",Number(walletTokenAmount));
      if (Number(walletTokenAmount) < stakeAmount) {
        window.alert("You have not enough tokens to bet on this!")
        return
      }

     
      try{
        console.log('sssssssss')
        var allowedTokens  = await erc20Contract.methods.allowance(this.currentAccount, BET_ADDRESS).call()
        allowedTokens = Number(web3.utils.fromWei(allowedTokens))
        console.log('allowedTokens ',allowedTokens)
        if (allowedTokens<stakeAmount){ //have to approve

          try{
            await erc20Contract.methods.approve(BET_ADDRESS, web3.utils.toWei(val)).send({from:this.currentAccount})
            await lotteryContract.methods.placeBet(this.tier.indexOf(val)).send({from:this.currentAccount})
            this.$router.push('/decision');
          }catch{
            window.alert(`Approve(${BET_ADDRESS}).send({from:${this.currentAccount}}) call failed! Please Connect Wallet or Retry!`)
          }
          
        }else{                          //already approved

          await lotteryContract.methods.placeBet(this.tier.indexOf(val)).send({from:this.currentAccount})
          this.$router.push('/decision');

        }
      }catch{
        this.approve = false;
      }
        // try{
        //   var allowedTokens =await erc20Contract.methods.allowance(this.currentAccount,ERC20_ADDRESS).call()
        //   allowedTokens = web3.utils.fromWei(allowedTokens)
        //   console.log('allowedTokens ',allowedTokens)
  
        //   if (Number(allowedTokens) < Number(stakeAmount)){ // have to approve
        //     try{
        //         await erc20Contract.methods.approve(BET_ADDRESS, web3.utils.toWei(val)).send({ from: this.currentAccount })
        //         var allowedTokensAgain = await erc20Contract.methods.allowance(this.currentAccount,ERC20_ADDRESS).call()
        //         allowedTokensAgain = web3.utils.fromWei(allowedTokensAgain)
        //         console.log("allowedTokensAgain", allowedTokensAgain)
        //         if (Number(allowedTokensAgain) >= Number(stakeAmount)){ //allowed tokens are really larger than the stake amount
        //             try{
        //               await lotteryContract.methods.placeBet(this.tier.indexOf(val)).send({from:this.currentAccount})
        //               console.log('transfered')
        //               this.$router.push('/decision');
        //             }catch{
        //               window.alert("Token Transfer failed. Please try again!")
        //             }
        //         }
        //     }catch{
        //         window.alert(`Approve(${ERC20_ADDRESS}).send({from:${this.currentAccount}}) call failed! Please Connect Wallet or Retry!`)
        //     }
        //   }else{
        //     console.log('not approved')
        //   }
        // }catch{
        //   window.alert('You already staked on this tier!')
        //   try{
        //     await erc20Contract.methods.placeBet(this.tier.indexOf(val)).send({from:this.currentAccount})
        //     console.log('transfered')
        //     this.$router.push('/decision');
        //   }catch{
        //     window.alert("Token Transfer failed. Please try again!")
        //   }
        // }
      }
  },
  async created() {
    const tierInWei =  await lotteryContract.methods.getBetAmounts().call();
    for (let i=0; i<tierInWei.length;i++){
      this.tier.push(web3.utils.fromWei(tierInWei[i]))
    }
    console.log(this.tier)
  }
}
</script>
<style scoped>
.tier {
  margin: 2rem 2rem 0 0;
}
</style>
