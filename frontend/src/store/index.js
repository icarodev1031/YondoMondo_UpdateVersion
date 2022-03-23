import { createStore } from 'vuex';
import {ethers} from 'ethers';

export default createStore({
  state() {
    return {
      connect:false,
      currentAccount: null,
      showProfile:false
    }
  },
  getters:{
    
  },
  mutations: {
    updateCurrentAccount(state, val){
      state.currentAccount = val;
    },
    updateLoading (state,val){
      state.connect = val
    },
    showProfile(state,val){
      state.showProfile = val
    }
  },
  actions: {
    async connectWalletAction({commit}){
      try{
          const {result} = await window.ethereum.send('eth_requestAccounts');
          if (result.length ===0){
            throw new Error('Connection error! Please refresh your browser');
          }else{
            commit("updateCurrentAccount", ethers.utils.getAddress(result[0]))
            commit("updateLoading", true)
          }
        }catch{
          commit("updateLoading", false)
        }
    },
    async showProfileAction({commit}){
      try{
        commit("showProfile", true);
      }catch{
        commit("showProfile",false)
      }
    }
  },
  modules: {}
});
