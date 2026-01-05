<script setup>
import { onMounted, ref } from 'vue';
import GameComponent from './GameComponent.vue';

const emit = defineEmits(['view'])

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
    emit('view', id)
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
    <table>
        <template v-if="gamesLoaded" v-for="game in games">
            <tr>
                <td>{{ game.white || 'N.N' }} - {{ game.black || 'N.N' }} | {{ game.result || 'unknown result' }}</td>
                <td>
                    <button class="btn-gambit btn-small" @click="view(game.id)">View</button>
                    <button class="btn-gambit btn-small" @click="studyAsWhite(game.id)">Study As White</button>
                    <button class="btn-gambit btn-small" @click="destroy(game.id)">Destroy</button>
                </td>
            </tr>
        </template>
    </table>
</template>