<script setup>
import { onMounted, ref } from 'vue';
import { fetchGames, createGameStudy } from '../assets/api.js'

const emit = defineEmits(['view'])

let games = ref({});

onMounted(async () => {
    games.value = await fetchGames()
})

const winner = (game) => {
    return game.result == '0-1' ? 'black' : 'white'
}

const view = (id) => {
    emit('view', id)
}

const study = async (game) => {
    const data = await createGameStudy(game)
    console.log(data)
}

const destroy = async (gameId) => {
    const response = await fetch(
        `http://192.168.1.22:3000/games/${gameId}`,
        {
            method: "DELETE"
        }
    )
    if (response.status == 204) {
        games.value = await fetchGames()
    }
}

</script>

<template>
    <h2>Games</h2>
    <template v-if="games">
        <table>
            <template v-for="game in games">
                <tr>
                    <td>{{ game.white || 'N.N' }} - {{ game.black || 'N.N' }} | {{ game.result || 'unknown result' }}
                    </td>
                    <td>
                        <RouterLink :to="{ name: 'games.show', params: { id: game.id } }" class="btn-gambit btn-small"
                            @click="view(game.id)">View</RouterLink>
                        <button class="btn-gambit btn-small" @click="study(game)">Study as {{ winner(game) }}</button>
                        <button class="btn-gambit btn-small btn-danger" @click="destroy(game.id)">Destroy</button>
                    </td>
                </tr>
            </template>
        </table>
    </template>
</template>
