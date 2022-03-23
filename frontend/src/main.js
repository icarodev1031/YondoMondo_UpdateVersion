import { createApp } from 'vue';
import bootPlugin from '@plugins/boot';
import App from './App.vue';
import mitt from 'mitt'
const emitter = mitt()
const app = createApp(App)
app.config.globalProperties.emitter = emitter;
app.use(bootPlugin).mount('#app');
