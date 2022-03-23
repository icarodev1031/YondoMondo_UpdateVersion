<template>
  <div id="result">
    <div class="container-block d-flex flex-column align-items-center w-full">
      <h3 class="text-white text-capitalize title">
        Result
      </h3>
      <div class="content-area">
        <div class="content-main">
            <div class="player-card">
                <div class="player">
                   <img
                        src="@assets/imgs/illustrations/charactors/yondo-171.png"
                        alt="twitter icon"
                    />
                </div>
                <div class="text-white text-center mt-2"> username</div>
            </div>
            <span class="vs">VS</span>
            <div class="player-card">
                <div class="player">
                    <img
                        src="@assets/imgs/illustrations/charactors/yondo-171.png"
                        alt="twitter icon"
                    />
                </div>
                <div class="text-white text-center mt-2"> username</div>
            </div>
        </div>
        <div class="start-btn">
            <img
                src="@assets/imgs/illustrations/start.png"
                alt="twitter icon"
            />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// import { FormButton } from '@components/Form';
export default {
  name: 'ResultComponent',
  data: function () {
    return {};
  },
  computed: {},
  methods: {}
};
</script>
