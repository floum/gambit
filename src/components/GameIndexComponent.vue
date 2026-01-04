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

const studyAsWhite = async (gameId) => {
    const response = await fetch(
        'http://192.168.1.22:3000/game_studies',
        {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                game_study: {
                    game_id: gameId,
                    color: 'w'
                }
            })
        }
    )
    const data = await response.json()
    console.log(response)
}

const destroy = async (gameId) => {
    const response = await fetch(
        `http://192.168.1.22:3000/games/${gameId}`,
        {
            method: "DELETE"
        }
    )
    console.log(response.status)
}

</script>

<template>
    <div id="grid" v-if="gamesLoaded">
        <div id="board" v-if="gameSelected">
            <GameComponent :id="gameId"></GameComponent>
        </div>
        <div id="aside">
            <template v-for="game in games">
                <div>
                    {{ game.white || 'N.N' }} - {{ game.black || 'N.N' }} | {{ game.result || 'unknown result' }}
                    <button class="btn-gambit btn-small" @click="view(game.id)">View</button>
                    <button class="btn-gambit btn-small" @click="studyAsWhite(game.id)">Study As White</button>
                    <button class="btn-gambit btn-small" @click="destroy(game.id)">Destroy</button>
                </div>
            </template>
        </div>
    </div>
</template>