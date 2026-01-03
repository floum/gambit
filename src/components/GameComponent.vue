<script setup>
import { ref, onMounted, watch } from 'vue'
import { TheChessboard } from 'vue3-chessboard';
import { Chess } from 'chess.js'

const props = defineProps(['id'])

let boardAPI;
let gameLoaded = ref(false)

const pgn = ref('')
const game = new Chess()
let index = 0

const loadGame = async() => {
    const response = await fetch(`http://192.168.1.22:3000/games/${props.id}`)
    const gameData = await response.json()
    game.loadPgn(gameData.pgn)
    
    gameLoaded.value = true
}

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
        <h2>Game {{ id }}</h2>
        <TheChessboard @board-created="(api) => (boardAPI = api)" />
        <button @click="previous">Previous</button>
        <button @click="next">Next</button>
    </template>
</template>