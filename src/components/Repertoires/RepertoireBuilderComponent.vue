<script setup>
import { ref, onMounted } from 'vue';
import { TheChessboard } from 'vue3-chessboard';
import { fetchRepertoire, lichessResponses, weightedRandom, createMove, confirmRepertoireMove } from '@/assets/api';

let boardAPI;

const props = defineProps(['id'])

var repertoire = ref({})
var inconsistentMove = ref(false)
var newMove = ref(undefined)
var opponentMove = ref(null)

onMounted(async () => {
    repertoire.value = await fetchRepertoire(props.id)
    await reset()
})

const playRandomLichessMove = async () => {
    var availableResponses = await lichessResponses(boardAPI.getFen())
    if (availableResponses.length == 0) {
        opponentMove.value = undefined
        return
    }
    opponentMove.value = weightedRandom(availableResponses)
    boardAPI.move(opponentMove.value.san)
}


const handleMove = async (move) => {
    if (move.color == (repertoire.value.white ? 'w' : 'b')) {
        var response = await createMove({move: move, repertoire: repertoire.value})
        console.log(response)
        switch (response.status) {
            case 200:
                inconsistentMove.value = false
                playRandomLichessMove()
                break
            case 201:
                newMove.value = await response.json()
                console.log(newMove.value)
                inconsistentMove.value = false
                break
            case 400:
                inconsistentMove.value = true
                boardAPI.undoLastMove()
                break
            }
    }
}

const reset = async () => {
    boardAPI.resetBoard()
    if (!repertoire.value.white) {
        boardAPI.setConfig({
            orientation: 'black'
        })
    }
    if (!repertoire.value.white) {
        opponentMove.value = weightedRandom(await lichessResponses('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'))
        boardAPI.move(opponentMove.value.san)
    }
    newMove.value = undefined
    inconsistentMove.value = false
}

const confirmMove = async () => {
    const response = await confirmRepertoireMove(newMove.value)
    console.log(response)
}
</script>

<template>
    <h2>{{ repertoire.name }}</h2>
    <TheChessboard @board-created="(api) => (boardAPI = api)" @move="handleMove" />
    <button @click="reset">Reset</button>
    <template v-if="newMove">
        <div>
            New Move Added! Go and Review it (probably) : 
            <a :href="'https://lichess.org/analysis/' + boardAPI.getHistory({verbose: true}).reverse()[0].before" target="_blank">Lichess</a>
            <div><button @click="confirmMove">Confirm</button></div>
        </div>
    </template>
    <template v-else>
        <div v-if="opponentMove">Count : {{ opponentMove.count }}</div>
    </template>
    <template v-if="inconsistentMove">
        <div>Inconsistent Move Played!</div>
    </template>
</template>
