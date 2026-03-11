<script setup>
import { ref, onMounted } from 'vue';
import { TheChessboard } from 'vue3-chessboard';
import { fetchRepertoire, randomLichessResponse, createMove } from '@/assets/api';

let boardAPI;

const props = defineProps(['id'])

var repertoire = ref({})
var closedline = ref(false)
var inconsistentMove = ref(false)
var addition = ref(false)

onMounted(async () => {
    repertoire.value = await fetchRepertoire(props.id)
    if (!repertoire.value.white) {
        boardAPI.setConfig({
            orientation: 'black'
        })
    }
    if (!repertoire.value.white) {
        var response = await randomLichessResponse('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
        boardAPI.move(response.san)
    }
})

const handleMove = async (move) => {
    if (move.color == (repertoire.value.white ? 'w' : 'b')) {
        var status = await createMove({move: move, repertoire: repertoire.value})
        console.log(status)
        switch (status) {
            case 200:
                var response = await randomLichessResponse(move.after)
                if (response) {
                    boardAPI.move(response.san)
                } else {
                    closedline.value = true
                }
                break
            case 201:
                addition.value = true
                var response = await randomLichessResponse(move.after)
                if (response) {
                    boardAPI.move(response.san)
                } else {
                    closedline.value = true
                }
                break
            case 400:
                inconsistentMove.value = true
                boardAPI.undoLastMove()
                break
            }
    }
}

const reset = () => {
    boardAPI.resetBoard()
    addition.value = false
    closedline.value = false
    inconsistentMove.value = false
}
</script>

<template>
    <h2>{{ repertoire.name }}</h2>
    <TheChessboard @board-created="(api) => (boardAPI = api)" @move="handleMove" />
    <button @click="reset">Reset</button>
    <template v-if="closedline">
        <div>Line Closed! Go and Review it (probably)</div>
    </template>
    <template v-if="addition">
        <div>New Move Added!</div>
    </template>
        <template v-if="inconsistentMove">
        <div>Inconsistent Move Played!</div>
    </template>
</template>
