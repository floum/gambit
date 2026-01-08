import { createWebHistory, createRouter } from 'vue-router'
import GamesComponent from '../components/GamesComponent.vue';
import StudiesComponent from '../components/StudiesComponent.vue';

const routes = [
    { path: '/', component: StudiesComponent, name: 'studies.index' },
    { path: '/Games', component: GamesComponent, name: 'games.index' }
]

const router = createRouter({
    history: createWebHistory(),
    routes,
})

export default router