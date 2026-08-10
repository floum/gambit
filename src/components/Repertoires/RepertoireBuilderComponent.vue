<script setup>
  import { ref, onMounted } from 'vue';
import { TheChessboard } from 'vue3-chessboard';

import { useLichessStore } from '@/stores/lichess';
import { useRepertoireStore } from '@/stores/repertoire';
import { useRepertoireMovesStore } from '@/stores/repertoireMove';

const lichess = useLichessStore()
const repertoireStore = useRepertoireStore()

let boardAPI;

const props = defineProps(['id'])
const nextMove= ref("free")

var newMove = ref(undefined)
var opponentMove = ref(null)

onMounted(async () => {
    await repertoireStore.load(props.id)
    await reset()
})

const play = (move) => {
    console.log("playing : " + move.san)
    boardAPI.move(move.san)
}

const handleMove = async (move) => {
    if (move.color == repertoireStore.color) {
        var m = await repertoireStore.add(move)
        if (m.status == "rejected") {
          boardAPI.undoLastMove()
          return false
        } 
        const fen = boardAPI.getFen()
        switch (nextMove.value) {
          case "random":
            play(await lichess.random(fen))
            break
          case "main":
            play(await lichess.main(fen))
            break
          case "weighted":
            play(await lichess.weighted(fen))
            break
        }
        return true
    }
}

const reset = async () => {
    boardAPI.resetBoard()
    console.log(repertoireStore.repertoire.id)
    if (!repertoireStore.white) {
        boardAPI.setConfig({
            orientation: 'black'
        })
    }
    if (!repertoireStore.white) {
        play(await lichess.weighted(boardAPI.getFen()))
    }
}

const confirmMove = async () => {
    return await movesStore.update(newMove.value, { status: "confirmed" })
}
</script>

<template>
  <h2>{{ repertoireStore.name }}</h2>
  <select v-model="nextMove">
    <option value="random">Random</option>
    <option value="weighted">Weighted Random</option>
    <option value="main">Main</option>
    <option value="free">Free</option>
  </select>
  <TheChessboard @board-created="(api) => (boardAPI = api)" @move="handleMove" />
  <button @click="reset">Reset</button>
</template>
