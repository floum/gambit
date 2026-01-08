import { createWebHistory, createRouter } from 'vue-router'
import GameIndexComponent from '../components/GameIndexComponent.vue';
import StudiesComponent from '../components/StudiesComponent.vue';
import GameComponent from '../components/GameComponent.vue';
import StudyIndexComponent from '../components/StudyIndexComponent.vue'
import StudyComponent from '../components/StudyComponent.vue';

const routes = [
    { path: '/', component: StudiesComponent, name: 'studies.index' },
    { path: '/Games', component: GameIndexComponent, name: 'games.index' },
    { path: '/Games/:id', component: GameComponent, name: 'games.show', props: true },
    { path: '/studies', component: StudyIndexComponent, name: 'studies.index'},
    { path: '/studies/:id', component: StudyComponent, name: 'studies.show', props: true},
]

const router = createRouter({
    history: createWebHistory(),
    routes,
})

export default router