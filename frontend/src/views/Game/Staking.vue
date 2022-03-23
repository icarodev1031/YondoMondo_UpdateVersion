<template>
  <div id="staking">
    <div class="container d-flex flex-column align-items-center w-full">
      <div class="d-flex flex-column container-box-1 w-full" v-if="wageCount <= 1">
        <h3 class="text-white text-capitalize title">
          How much do you want to wager?
        </h3>
        <div>
          <a class="d-block me-3 me-xxl-4 wage-btn-area-1" @click="handleWager(1)">
            <img
              src="@assets/imgs/illustrations/wager_btn_1_0.png"
              v-if="isIncreaseWageActive"
              alt="twitter icon"
            />
            <img
              src="@assets/imgs/illustrations/wager_btn_1_1.png"
              v-else
              alt="twitter icon"
            />
          </a>
        </div>
        <div class="increase-btn-area-1">
          <a class="d-block me-3 me-xxl-4" @click="handleIncreaseWage">
            <img
              src="@assets/imgs/illustrations/increase_wage.png"
              v-if="isIncreaseWageActive"
              alt="twitter icon"
            />
            <img
              src="@assets/imgs/illustrations/increase_wage.png"
              v-else
              alt="twitter icon"
            />
          </a>
        </div>
      </div>
      <div v-else class="d-flex flex-column align-items-center">
        <span class="text-white text-capitalize caption"
          >Thank you for entering, The game begins on [date] at [time]. See you
          then.</span
        >
        <a
          class="d-block me-3  increase-btn-area-2 d-flex justify-content-center"
          @click="handleIncreaseWage"
        >
          <img
            src="@assets/imgs/illustrations/increase_wage.png"
            v-if="isIncreaseWageActive"
            alt="twitter icon"
          />
          <img
            src="@assets/imgs/illustrations/increase_wage.png"
            v-else
            alt="twitter icon"
          />
        </a>
        <h3 class="text-white text-capitalize title">
          How much do you want to wager?
        </h3>
        <div class="d-flex wage-btn-area-2">
          <div v-for="i in wageBtnArr[wageCount - 1]" :key="i">
            <a class="d-block me-3 me-xxl-4" style="margin-bottom: 35.98px" @click="handleWager(i)">
              <img
                :src="require(`@/assets/imgs/illustrations/wager_btn_${i}_0.png`)"
                v-if="isWageClicked"
                alt="twitter icon"
                v-bind:class="wageBtnSizeClass"
              />
              <img
                v-else
                alt="twitter icon"
                :src="require(`@/assets/imgs/illustrations/wager_btn_${i}_1.png`)"
                v-bind:class="wageBtnSizeClass"
              />
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// import { FormButton } from '@components/Form';
export default {
  name: 'StakingComponent',
  data: function () {
    return {
      count: 1,
      isIncreaseWageActive: false,
      isWageClicked: false
    };
  },
  computed: {
    wageBtnArr() {
      return [1, 2, 3, 5, 8, 10];
    },
    wageCount() {
      return this.count;
    },
    wageBtnSizeClass() {
      return this.count > 4 ? 'wage-btn-size-2' : 'wage-btn-size-1';
    },
    srcPath() {
      return '@assets/imgs/illustrations/wager_btn_1_0';
    }
  },
  methods: {
    increaseCount() {
      if (this.count <= 6) return this.count++;
      else return (this.count = 1);
    },
    handleIncreaseWage() {
      this.isIncreaseWageActive != this.isIncreaseWageActive;
      this.increaseCount();
    },
    handleWager(val){
      console.log(val)
      /////
    }
  }
};
</script>
