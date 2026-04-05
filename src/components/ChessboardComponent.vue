<script setup>
import { onMounted, watch } from 'vue'

import { TheChessboard } from 'vue3-chessboard';

const props = defineProps(['fen'])

watch(() => props.fen, (newFen) => {
  console.log("Parent updated:", newFen)
  boardAPI.setPosition(newFen)
})

console.log(props.fen)
var boardAPI

onMounted(() => {
})

const setBoard = (api) => {
    boardAPI = api
}

</script>

<template>
    <TheChessboard @board-created="setBoard" />
</template>