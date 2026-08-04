<script setup>
import { TheChessboard } from 'vue3-chessboard'
import StudyResultsComponent from './StudyResultsComponent.vue'
import { ref, onMounted } from 'vue';
import { apiUrl, fetchStudy } from '../assets/api.js'

const props = defineProps(['id'])

let study = ref()

onMounted(async () => {
    study.value = await fetchStudy(props.id)
})

let boardAPI;

const setBoard = () => {
    boardAPI.setConfig({
        lastMove: null,
        fen: study.value.expected_moves[study.value.game_study_moves.length].before,
    })
}

const loadBoard = (api) => {
    boardAPI = api
    boardAPI.setConfig({
        orientation: study.value.color == 'b' ? 'black' : 'white',
    })
    setBoard()
}

const handleMove = async (move) => {
    console.log(move)
    const response = await fetch(
        `${apiUrl}/game_studies/${study.value.id}/game_study_moves`,
        {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ move: move })
        }
    )
    if (response.status == 201) {
        study.value.game_study_moves.push(move)
    }
    setBoard()
}
</script>

<template>
    <template v-if="study">
        <div>Study {{ study.id }} - {{ study.created_at }}</div>
        <template v-if="study.complete">
            <StudyResultsComponent :study="study"></StudyResultsComponent>
        </template>
        <template v-else>
            <TheChessboard @board-created="loadBoard" @move="handleMove" />
        </template>
    </template>
</template>
