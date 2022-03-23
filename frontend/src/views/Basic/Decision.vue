<template>
  <div class="container d-flex justify-content-right flex-column">
    <div class="row container" >
      <div class="col-4 d-flex justify-content-center flex-column">
        <button class="btn mt-4" @click="handleDecision(1,1)" v-bind:class="{'btn-primary':selectedChoice[0]==1}">HOOK</button>
        <button class="btn mt-4" @click="handleDecision(1,2)" v-bind:class="{'btn-primary':selectedChoice[0]==2 }">JAB</button>
        <button class="btn mt-4 mb-4" @click="handleDecision(1,3)" v-bind:class="{'btn-primary':selectedChoice[0]==3}">KICK</button>

      </div>
      <div class="col-4 d-flex justify-content-center flex-column">
        <button class="btn mt-4" @click="handleDecision(2,1) " v-bind:class="{'btn-primary':selectedChoice[1]==1}">HOOK</button>
        <button class="btn mt-4" @click="handleDecision(2,2)" v-bind:class="{'btn-primary':selectedChoice[1]==2}">JAB</button>
        <button class="btn mt-4 mb-4" @click="handleDecision(2,3)" v-bind:class="{'btn-primary':selectedChoice[1]==3}">KICK</button>
      </div>
      <div class="col-4 d-flex justify-content-center flex-column">
        <button class="btn mt-4" @click="handleDecision(3,1)" v-bind:class="{'btn-primary':selectedChoice[2]==1}">HOOK</button>
        <button class="btn mt-4"  @click="handleDecision(3,2)" v-bind:class="{'btn-primary':selectedChoice[2]==2}">JAB</button>
        <button class="btn  mt-4 mb-4" @click="handleDecision(3,3)" v-bind:class="{'btn-primary':selectedChoice[2]==3}" >KICK</button>
      </div>
    </div>
    <div>
      <button class="btn btn-success mt-4 submit" @click="submitDecision(selectedChoice)">Submit</button>
    </div>
  </div>
</template>

<script>
import {mapState} from 'vuex'
import {
  lotteryContract
} from '@src/web3/web3.js';
export default {
  name: 'DecisionComponent',
  data:()=>{
    return{
      selectedChoice:[0,0,0],
    }
  },
   computed: {
    ...mapState(['currentAccount'])
  },
  methods:{
    handleDecision(col,row){
      this.selectedChoice[col-1] = row;
    },
    async submitDecision(valueArr){
      var flag = true;
      for (let i=0; i<valueArr.length;i++){
        if (valueArr[i]==0)
          flag=false
      }
      if (!flag) window.alert('Choice invalid. Please check again!')
      try{
        console.log(this.selectedChoice[0],this.selectedChoice[1],this.selectedChoice[2])
        await lotteryContract.methods.setRoundOption(this.selectedChoice[0],this.selectedChoice[1],this.selectedChoice[2]).send({from:this.currentAccount})  
        console.log('Decision submitted')
      }catch{
        window.alert("Decision submitting failed")
      }
    }
  }
}
</script>
<style scoped>
  .container{
    width: 70%;
    margin-top:100px;
    margin-left:auto;
    margin-right:auto;
    border: solid 1px #999;
  }
  .submit{
    float:right;
    margin-bottom: 20px;
  }
</style>
