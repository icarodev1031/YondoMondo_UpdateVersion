<template>
  <nav class="navbar sticky-top navbar-expand-lg navbar-light bg-light">
    <router-link to="/" class="navbar-brand"> Lottery </router-link>
    <button
      class="navbar-toggler"
      type="button"
      data-toggle="collapse"
      data-target="#navbarNav"
      aria-controls="navbarNav"
      aria-expanded="false"
      aria-label="Toggle navigation"
    >
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse d-flex justify-content-between" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="#">Link1</a>
        </li>
        
        <li class="nav-item">
          <button class="nav-link" @click="setTokenAddress">Set ERC20 Token Address</button>
        </li>
        <li class="nav-item">
          <button class="nav-link" @click="setTokenTier">Set Token Tier</button>
        </li>
        <li class="nav-item">
          <button class="nav-link" @click="planRounds">Plan Rounds</button>
        </li>
      </ul>
      <button class="btn btn-info" @click="handleConnectWallet">Connect Wallet</button>

    </div>
  </nav>
</template>

<script>
import { mapState } from 'vuex';
import {
  lotteryContract
} from '@src/web3/web3.js';
import web3 from 'web3';
import {ERC20_ADDRESS,CONTRACT_OWNER_ADDRESS} from '@src/config/const.js'

export default {
  name: 'BasicNavbar',
  computed: {
    ...mapState(['currentAccount', 'connect'])
  },
  data() {},
  methods: {
    async planRounds(){
        await lotteryContract.methods.planRounds().send({from:this.currentAccount})
    },
    async handleConnectWallet() {
      await this.$store.dispatch('connectWalletAction');
      console.log(this.connect);
      this.isActive = !this.isActive;

      if (this.connect){
        await this.$store.dispatch("showProfileAction");
        this.emitter.emit("aaa",true)
      }
    },
    async setTokenTier(){
      console.log(web3.utils.toWei("200"))
      try{
        await lotteryContract.methods.setBetAmounts([web3.utils.toWei("1000"),web3.utils.toWei("1500"),web3.utils.toWei("2500"),web3.utils.toWei("4000"),web3.utils.toWei("8000"),web3.utils.toWei("10000")]).send({
          from:CONTRACT_OWNER_ADDRESS
        })
        window.alert("Action Success!")
      }catch{
        window.alert('Action failed!')
      }
    },
    async setTokenAddress(){
      try{
        await lotteryContract.methods.setBetToken(ERC20_ADDRESS).send({from:CONTRACT_OWNER_ADDRESS})
      }catch{
        window.alert("Setting ERC20 token address failed!")
      }
    }
  },
  setup(){
    
  },
  created(){
  }
};
</script>

<style>
</style>
