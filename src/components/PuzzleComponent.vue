<script setup>
import { shallowRef } from 'vue'
import { TheChessboard } from 'vue3-chessboard';
import SuccessComponent from './SuccessComponent.vue';

let boardAPI;
let boardConfig = {};

let success = shallowRef(false);
let completed = shallowRef(false)
let index = 0

let puzzle;

const start = (api) => {
  boardAPI = api
  reset()
}

const reset = async () => {
  const response = await fetch('http://192.168.1.22:3000/random-move')
  puzzle = await response.json()
  boardAPI.setPosition(puzzle.before)
  completed.value = false
  success.value = false
}

const handleMove = (move) => {
  console.log(move)
  console.log(puzzle)
  success.value = (move.from == puzzle.from && move.to == puzzle.to)
  completed.value = true
}

const next = () => {
  index++
  reset()
}

</script>

<template>
  <div id="grid">
    <div id="board">
      <TheChessboard :board-config="boardConfig" @board-created="start" @move="handleMove" />
    </div>
    <div id="results">
      <button v-if="completed" @click="next">Next</button>
      <SuccessComponent v-if="success"></SuccessComponent>
    </div>
  </div>
</template>

<style scoped>
#grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-gap: 10px;
}

#board {
  grid-column: 1 / 3;
}

#results {
  grid-column: 3;
}
</style>