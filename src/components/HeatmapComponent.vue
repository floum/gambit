<script setup>
import { TheChessboard } from 'vue3-chessboard'

var boardAPI;
const loadGame = (api) => {
    boardAPI = api
    drawHeatmap()
}

const handleMove = (move) => {
    drawHeatmap()
}

const drawHeatmap = () => {
    var moves = boardAPI.game.moves()
    boardAPI.setShapes([])
    boardAPI.setShapes(
        moves.map(
        (move) => { 
            return { orig: move, brush: 'green' }
        }
        )
    )
}

</script>

<template>
    <h2>HeatMap</h2>
    <TheChessboard @board-created="loadGame" @move="handleMove" />
</template>