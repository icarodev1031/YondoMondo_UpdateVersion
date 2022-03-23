import { createRouter, createWebHistory } from 'vue-router';
import { AppHomeLayout, AppBasicLayout ,AppGameLayout} from '@layouts';
import Home from '@views/Home';
import PreSale from '@views/PreSale';
import PublicMint from '@views/PublicMint';
import StakingComponent from '@views/Game/Staking'
import DecisionComponent from '@views/Game/Decision';
import Decision1Component from '@views/Game/Decision1';
import ListComponent from '@views/Game/List';
import ResultComponent from '@views/Game/Result';
import Result1Component from '@views/Game/Result1';
import Result2Component from '@views/Game/Result2';
import ConnectComponent from '@views/Game/Connect';

const routes = [
  {
    path: '/',
    component: AppHomeLayout,
    children: [
      {
        path: '',
        name: 'Home',
        component: Home
      }
    ]
  },
  {
    path: '/presales',
    component: AppBasicLayout,
    children: [
      {
        path: '',
        name: 'PreSale',
        component: PreSale
      }
    ]
  },
  {
    path: '/mint',
    component: AppBasicLayout,
    children: [
      {
        path: '',
        name: 'PublicMint',
        component: PublicMint
      }
    ]
  },
  {
    path:'/game',
    component:AppGameLayout,
    children:[
      {
        path:'',
        name:'connect',
        component:ConnectComponent
      },
      {
        path:'staking',
        name:'Staking',
        component:StakingComponent
      },
      {
        path:'decision',
        name:'Decision',
        component:DecisionComponent
      },
      {
        path:'decision1',
        name:'Decision1',
        component:Decision1Component
      },
      {
        path:'list',
        name:'List',
        component:ListComponent
      },
      {
        path:'result',
        name:'Result',
        component:ResultComponent
      },
      {
        path:'result1',
        name:'Result1',
        component:Result1Component
      },
      {
        path:'result2',
        name:'Result2',
        component:Result2Component
      },
      
    ]
  }
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
});

export default router;
