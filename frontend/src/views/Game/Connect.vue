<template>
  <div id="connect">
    <div class="container d-flex flex-column align-items-center">
      <h3 class="text-white text-capitalize title text-center">Connect Metamask Wallet</h3>
      <div class="image-area">
        <img
          src="@assets/imgs/illustrations/metamask.png"
          alt="main hightlight image"
        />
      </div>
      <div>
          <a class="d-block mt-5" style="cursor:pointer" @click="handleConnectWallet" >
            <img
              src="@assets/imgs/illustrations/connect_metamask.png"
              v-if="isActive"
              alt="twitter icon"
            />
            <div v-else class="d-flex">
              <img
                src="@assets/imgs/illustrations/connect_metamask.png"
                alt="twitter icon"
              />
            </div>
          </a>
      </div>
       <!-- <v-img style="z-index: 0" :src="require(`../assets/imgs/illustrations/connect_metamask.png')" @click="handleConnectWallet">
            <v-card-title class="align-end fill-height" primary-title>

            <v-btn class="blue" style="z-index: 9999" v-on:click="action2">clickable</v-btn>
           </v-card-title>

      </v-img>  -->
    </div>
  </div>
</template>

<script>
// import { FormButton } from '@components/Form';
import {mapState} from 'vuex';
// import web3 from 'web3'
import {
  // erc20Contract,
  // tokenBalance,
  lotteryContract
} from '@src/web3/web3.js';
// import {
  // BET_ADDRESS,
// ERC20_ADDRESS
// } from '@src/config/const.js'
export default {
  name: 'ConnectComponent',
  computed:{
    ...mapState(['count','currentAccount','connect']),
  },
  data() {
    return {
      isActive: true,
      betLevel:0
    };
  },
  methods: {
    async handleConnectWallet(){
      await this.$store.dispatch("connectWalletAction");
      console.log(this.connect)
      this.isActive = !this.isActive;

      if (this.connect){
        this.betLevel = await lotteryContract.methods.getBetLevel().call();
        this.$router.push('/game/staking');
        console.log(this.betLevel);
      }
    },
    
  },
  mounted:{
    
  }
  
  
};
</script>
