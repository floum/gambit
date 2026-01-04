<script setup>
import { ref } from 'vue'
import { TheChessboard } from 'vue3-chessboard'
import { Chess } from 'chess.js'

const props = defineProps(['study'])
let completed = ref(false)
let boardAPI;
let history = [];
let index = 0;

const loadGame = (api) => {
    boardAPI = api
    boardAPI.loadPgn(props.study.game.pgn)
    history = boardAPI.getHistory({ verbose: true })
    if (props.study.color == 'b') {
        index++
    }
    index += props.study.game_study_moves.length * 2
    if (index >= history.length) {
        completed.value = true
    }
    boardAPI.resetBoard()
    setBoard()
}

const setBoard = () => {
    if (index >= 1 && !completed.value) {
        boardAPI.setPosition(history[index].before)
        boardAPI.setConfig({
            orientation: props.study.color == 'b' ? 'black' : 'white',
            fen: history[index].before,
            lastMove: [history[index - 1].from, history[index - 1].to]
        })
    }
}

const handleMove = async (move) => {
    console.log(move)
    const response = await fetch(
        `http://192.168.1.22:3000/game_studies/${props.study.id}/game_study_moves`,
        {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(move)
        }
    )
    let game_study_move = await response.json()
    index += 2
    setBoard()
}
</script>

<template>
    <div>Study {{ study.id }} - {{ study.created_at }}</div>
    <template v-if="completed">
        Completed!
    </template>
    <TheChessboard v-else @board-created="loadGame" @move="handleMove" />
</template>