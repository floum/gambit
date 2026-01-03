<script setup>
import { ref } from 'vue'
import { TheChessboard } from 'vue3-chessboard';
import { Chess } from 'chess.js'

let boardAPI;
let gameLoaded = ref(false)

const pgn = ref('')
const game = new Chess()
let index = 0

const loadGame = () => {
    game.loadPgn(pgn.value)
    gameLoaded.value = true
}

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

const save = async () => {
    console.log(pgn.value)
    const response = await fetch(
        'http://192.168.1.22:3000/games',
        {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ pgn: pgn.value })
        }
    )
    const data = await response.json()
    console.log(data)
}
</script>

<template>
    <div v-if="gameLoaded">
        <div id="grid">
            <div id="board">
                <TheChessboard @board-created="(api) => (boardAPI = api)" />
                <button @click="previous">Previous</button>
                <button @click="next">Next</button>
            </div>
            <div id="aside">
                <button class="btn-gambit" @click="save">Save Game</button>
            </div>
        </div>
    </div>
    <div v-else>
        <div>
            <textarea v-model="pgn" rows="25" cols="80"></textarea>
        </div>
        <div>
            <button class="btn-gambit" @click="loadGame">Load</button>
        </div>
    </div>
</template>