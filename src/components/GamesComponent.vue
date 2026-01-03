<script setup>
import { ref } from 'vue'
import GameIndexComponent from './GameIndexComponent.vue';
import GameImportComponent from './GameImportComponent.vue';

let activeComponent = ref(GameImportComponent)

const index = () => {
    activeComponent.value = GameIndexComponent
}

const importGame = () => {
    activeComponent.value = GameImportComponent
}
</script>

<template>
    <div class="navbar">
        <h2>Games</h2>
        <button class="btn-gambit" @click="importGame">Import</button>
        <button class="btn-gambit" @click="index">Index</button>
    </div>
    <component :is="activeComponent"></component>
</template>
