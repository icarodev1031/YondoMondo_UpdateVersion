<template>
  <game-navbar />
  <router-view />
</template>

<script>
import { GameNavbar } from '@components/Game';
export default {
  name: 'AppGameLayout',
  components: {
    GameNavbar
  },
  setup() {}
};
</script>
