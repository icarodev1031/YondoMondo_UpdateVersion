<template>
  <div class="px-4">
    <basic-navbar />
    <router-view />
  </div>
</template>

<script>
import { BasicNavbar } from '@components/Basic';
export default {
  name: 'AppBasicLayout',
  components: {
    BasicNavbar
  },
  setup() {}
};
</script>
