<script setup>
import { TheChessboard } from 'vue3-chessboard'
import StudyResultsComponent from './StudyResultsComponent.vue'

const props = defineProps(['study'])
let boardAPI;

const setBoard = () => {
    boardAPI.setConfig({
        lastMove: null,
        fen: props.study.expected_moves[props.study.game_study_moves.length].before,
    })
}

const loadBoard = (api) => {
    boardAPI = api
    boardAPI.setConfig({
        orientation: props.study.color == 'b' ? 'black' : 'white',
    })
    setBoard()
}

const handleMove = async (move) => {
    console.log(move)
    const response = await fetch(
        `http://192.168.1.22:3000/game_studies/${props.study.id}/game_study_moves`,
        {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ move: move })
        }
    )
    if (response.status == 201) {
        props.study.game_study_moves.push(move)
    }
    setBoard()
}
</script>

<template>
    <div>Study {{ study.id }} - {{ study.created_at }}</div>
    <template v-if="study.complete">
        <StudyResultsComponent :study="props.study"></StudyResultsComponent>
    </template>
    <template v-else>
        <TheChessboard @board-created="loadBoard" @move="handleMove" />
    </template>

</template>