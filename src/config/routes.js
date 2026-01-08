import { createWebHistory, createRouter } from 'vue-router'
import GamesComponent from '../components/GamesComponent.vue';
import GameComponent from '../components/GameComponent.vue';
import StudyIndexComponent from '../components/StudyIndexComponent.vue'
import StudyComponent from '../components/StudyComponent.vue';

const routes = [
    { path: '/', component: StudyIndexComponent, name: 'root' },
    { path: '/games', component: GamesComponent, name: 'games.index' },
    { path: '/games/:id', component: GameComponent, name: 'games.show', props: true },
    { path: '/studies', component: StudyIndexComponent, name: 'studies.index'},
    { path: '/studies/:id', component: StudyComponent, name: 'studies.show', props: true},
]

const router = createRouter({
    history: createWebHistory(),
    routes,
})

export default router