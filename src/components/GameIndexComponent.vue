<script setup>
import { onMounted, ref } from 'vue';
import GameComponent from './GameComponent.vue';

let games;
let gameId = ref(null);
let gameSelected = ref(false); 
let gamesLoaded = ref(false);

onMounted(async () => {
    const response = await fetch(
        'http://192.168.1.22:3000/games'
    )
    games = await response.json()
    gamesLoaded.value = true
})

const view = (id) => {
    gameId.value = id
    gameSelected.value = true
}

</script>

<template>
    <div id="grid" v-if="gamesLoaded">
        <div id="board" v-if="gameSelected">
            <GameComponent :id="gameId"></GameComponent>
        </div>
        <div id="aside">
            <template v-for="game in games">
                <div>{{ game.id }} <button class="btn-gambit" @click="view(game.id)">View</button></div>
            </template>
        </div>
    </div>
</template>