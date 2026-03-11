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

const start = () => {
    boardAPI.viewStart()
}

const next = () => {
    boardAPI.viewNext()
}

const previous = () => {
    boardAPI.viewPrevious()
}

const end = () => {
    boardAPI.stopViewingHistory()
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
        <div class="left">
            <TheChessboard @board-created="loadGame" />
        </div>
        <button class="btn-gambit" @click="start"><<</button>
        <button class="btn-gambit" @click="previous">Previous</button>
        <button class="btn-gambit" @click="next">Next</button>
        <button class="btn-gambit" @click="end">>></button>

    </template>
</template>

<style>
</style>