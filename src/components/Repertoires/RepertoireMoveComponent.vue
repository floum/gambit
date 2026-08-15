<script setup>
import { TheChessboard } from 'vue3-chessboard';
import lichessIcon from '@/assets/lichess-dark.svg'
import { useRepertoireMovesStore } from '@/stores/repertoireMove';

const props = defineProps(['repertoireMove'])
const repertoireMovesStore = useRepertoireMovesStore()


const setBoard = (api) => {
const color = props.repertoireMove.fen.split(' ')[1] == "w" ? "white" : "black"
  api.setConfig({
    fen: props.repertoireMove.fen,
    orientation: color,
  })
}

const confirm = async () => {
  return await repertoireMovesStore.confirm(props.repertoireMove)
}

const reject = async () => {
  return await repertoireMovesStore.reject(props.repertoireMove)
}

const destroy = async () => {
  return await repertoireMovesStore.destroy(props.repertoireMove)
}
</script>

<template>
  <TheChessboard class="chessboard" @board-created="setBoard" />
  <div>{{ props.repertoireMove.san }} : {{ repertoireMove.status }}</div>
  <div>
    <a :href="'https://lichess.org/analysis/' + props.repertoireMove.fen" target="_blank">
        <img :src="lichessIcon" alt="Lichess" class="lichess-icon">
    </a>
    <button class="btn-gambit btn-small" @click="confirm">
      <i class="bi bi-check-circle-fill text-success"></i>
    </button>
    <button class="btn-gambit btn-small" @click="reject">
      <i class="bi bi-x-lg text-danger"></i>
    </button>
    <button class="btn-gambit btn-danger btn-small" @click="destroy">
      <i class="bi bi-trash-fill text-danger"></i>
    </button>
  </div>
</template>

<style>
.chessboard {
  max-width: 40vh !important;
  max-height: 40vh !important;
}
</style>

<style scoped>
.lichess-icon {
  width: 24px;
  height: 24px;
}
</style>
