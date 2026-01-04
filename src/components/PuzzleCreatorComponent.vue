<script setup>
import { TheChessboard } from 'vue3-chessboard';

let boardConfig;
let boardAPI;

const save = async () => {
  let move = boardAPI.getLastMove()
  const response = await fetch(
    'http://192.168.1.22:3000/moves',
    {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(move)
    })
  const data = await response.json()
}


</script>
<template>
  <div id="grid">
    <div id="board">
      <TheChessboard :board-config="boardConfig" @board-created="(api) => (boardAPI = api)" />
    </div>
    <div id="aside">
      <button class="btn-gambit" @click="save">Save last move</button>
    </div>
  </div>
</template>

<style>
#grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-gap: 10px;
}

#board {
  grid-column: 1 / 3;
}

#aside {
  grid-column: 3;
}
</style>