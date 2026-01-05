<script setup>
import { ref } from 'vue'
import StudyIndexComponent from './StudyIndexComponent.vue'
import StudyComponent from './StudyComponent.vue';

let id = ref(null)
let study = ref(null)

const index = () => {
    id.value = null
    study.value = null
}

const selected = async(studyId) => {
    const response = await fetch(`http://192.168.1.22:3000/game_studies/${studyId}`)
    study.value = await response.json()
}
</script>

<template>
    <div>
    <div class="navbar">
        <h2 class="nav-title">Studies</h2>
        <button class="btn-gambit" @click="index">Index</button>
    </div>
    <template v-if="study">
        <StudyComponent :study="study"></StudyComponent>
    </template>
    <template v-else>
        <StudyIndexComponent @selected="selected" />
    </template>
    </div>
</template>