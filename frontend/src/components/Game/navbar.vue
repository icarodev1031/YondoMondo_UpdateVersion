<template>
  <nav id="game_navbar" class="navbar navbar-expand-lg">
    <div class="container">
      <a class="text-white navbar-brand" href="/">YondoMondo</a>
      <button
        class="navbar-toggler"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbar-dropdown"
        aria-controls="navbar-dropdown"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <img src="@assets/imgs/icons/justify-full-align-svgrepo-com.svg" style="color:white" alt="navbar icon" />
      </button>

      <div id="navbar-dropdown" class="  collapse navbar-collapse">
        <ul class="navbar-nav">
          <li class="nav-item text-center">
            <a href="/#universe" class="nav-link text-capitalize text-white">
              home
            </a>
          </li>
          <li class="nav-item text-center">
            <a href="/#roadmap" class="nav-link text-capitalize text-white">
              lorem
            </a>
          </li>
          <li class="nav-item text-center">
            <a href="/#purpose" class="nav-link text-capitalize text-white">
              lorem
            </a>
          </li>
          <li class="nav-item text-center">
            <a href="/#team" class="nav-link text-capitalize text-white">
              lorem
            </a>
          </li>
          <li class="nav-item address-image d-flex align-items-center">
            <div v-if="connect==true" class="d-flex align-items-center">
              <img
                src="@assets/imgs/illustrations/plus.png"
                alt="twitter icon"
                class="d-block me-3 me-xxl-4" 
                
              />
              <span style="font-size:10px; color:white; border-bottom-style:solid; border-bottom-color:white, border-bottom-width:1px">{{shortenAddress}}</span>
            </div>
            <div v-else class="d-flex pt-3">
              <img
                src="@assets/imgs/illustrations/connect_wallet.png"
                alt="twitter icon"
                class="d-block me-3 me-xxl-4"
              />
            </div>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script>
import {mapState} from 'vuex';
export default {
  name: 'GamenavbarComponent',
  computed:{
    ...mapState(['count','currentAccount','connect']),
    shortenAddress(){
      return this.currentAccount.substring(1,13)+'...'
    }
  },
  
};
</script>
