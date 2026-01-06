<script setup>
import { ref } from 'vue'
import GameIndexComponent from './GameIndexComponent.vue';
import GameComponent from './GameComponent.vue';
import GameImportComponent from './GameImportComponent.vue';

let activeTab = ref('index')
let gameId = ref(null)

const index = () => {
    gameId.value = null
    activeTab.value = 'index'
}

const importGame = () => {
    gameId.value = null
    activeTab.value = 'import'
}

const viewGame = (id) => {
    gameId.value = id
    activeTab.value = null
}

</script>

<template>
    <div>
        <div class="navbar">
            <h2 class="nav-title">Games</h2>
            <button class="btn-gambit" @click="index">Index</button>
            <button class="btn-gambit" @click="importGame">Import</button>
        </div>
        <div>
            <GameIndexComponent v-if="activeTab == 'index'" @view="viewGame"></GameIndexComponent>
            <GameImportComponent v-if="activeTab == 'import'" @imported="index"></GameImportComponent>
            <GameComponent v-if="gameId" :id="gameId"></GameComponent>
        </div>
    </div>
</template>
