<script setup>
import { ref, onMounted, watch, computed } from 'vue'
import { TheChessboard } from 'vue3-chessboard';
import { Chess } from 'chess.js'
import { fetchGame } from '../assets/api.js'

const props = defineProps(['id'])

let boardAPI;
let gameLoaded = ref(false)
let gameData = ref({})

const pgn = ref('')
const game = new Chess()
let index = 0

const loadGame = async() => {
    gameData = await fetchGame(props.id)
    game.loadPgn(gameData.pgn)
    gameLoaded.value = true
}

const gameName = computed(() => {
    return `${gameData.white} - ${gameData.black} ${gameData.result}`
})

onMounted(loadGame)

watch(props, async() => {
    loadGame()
    index = 0
    boardAPI.setPosition(game.history({ verbose: true })[index].before)
})

const next = () => {
    index++
    boardAPI.setPosition(game.history({ verbose: true })[index].before)
}

const previous = () => {
    index--
    if (index <= 0) {
        index = 0
    }
    boardAPI.setPosition(game.history({ verbose: true })[index].before)
}


</script>

<template>
    <template v-if="gameLoaded">
        <h2>{{ gameName }}</h2>
        <TheChessboard @board-created="(api) => (boardAPI = api)" />
        <button @click="previous">Previous</button>
        <button @click="next">Next</button>
    </template>
</template>