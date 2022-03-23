<template>
  <div>Home</div>
  <profile-modal :showProfile1="showProfile" />
</template>

<script>
import ProfileModal from './Dialog.vue';
import axios from 'axios';
export default {
  name: 'HomeComponent',
  data: () => ({
    showProfile: false
  }),

  components: {
    ProfileModal
  },
  mounted() {
    this.emitter.on('aaa', (arg) => {
      console.log('xxxxxxxxxx', arg);
      this.showProfile = arg;
    });
    let apiURL = 'http://localhost:4000/api';
    axios.get(apiURL).then((res) => {
      console.log(res);
    });
  }
};
</script>
