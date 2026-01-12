<script setup>
import { ref, computed, onMounted } from 'vue'
import { TheChessboard } from 'vue3-chessboard';
import { fetchGame } from '../assets/api.js'

const props = defineProps(['id'])

let boardAPI;
let game = ref(null)

onMounted(async() => {
    game.value = await fetchGame(props.id)
})

const gameName = computed(() => {
    return `${game.value.white} - ${game.value.black} ${game.value.result}`
})

const next = () => {
    boardAPI.viewNext()
}

const previous = () => {
    boardAPI.viewPrevious()
}

const loadGame = async(api) => {
    boardAPI = api
    boardAPI.loadPgn(game.value.pgn)
    boardAPI.viewHistory()
    boardAPI.viewStart()
}
</script>

<template>
    <template v-if="game">
        <h2>{{ gameName }}</h2>
        <TheChessboard @board-created="loadGame" />
        <button class="btn-gambit" @click="previous">< Previous</button>
        <button class="btn-gambit" @click="next">Next ></button>
    </template>
</template>