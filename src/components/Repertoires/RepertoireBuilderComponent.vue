<script setup>
import { ref, onMounted, computed } from 'vue';
import { TheChessboard } from 'vue3-chessboard';
import { weightedRandom } from '@/assets/utils';
import { createMove, confirmRepertoireMove } from '@/assets/api';

import { useLichessResponseStore } from '@/stores/lichessResponse';
import { useRepertoireStore } from '@/stores/repertoire';
import { useRepertoireMovesStore } from '@/stores/repertoireMove';

const lichess = useLichessResponseStore()
const repertoireStore = useRepertoireStore()
const movesStore = useRepertoireMovesStore()

let boardAPI;

const props = defineProps(['id'])

var repertoire = ref({})
var inconsistentMove = ref(false)
var newMove = ref(undefined)
var opponentMove = ref(null)

onMounted(async () => {
    repertoire.value = await repertoireStore.get(props.id)
    movesStore.repertoire = repertoire.value
    movesStore.moves = repertoire.value.repertoireMoves
    await reset()
})

const playRandomLichessMove = async () => {
    var availableResponses = await lichess.responses(boardAPI.getFen())
    if (availableResponses.length == 0) {
        opponentMove.value = undefined
        return
    }
    opponentMove.value = weightedRandom(availableResponses)
    boardAPI.move(opponentMove.value.san)
}


const handleMove = async (move) => {
    if (move.color == (repertoire.value.white ? 'w' : 'b')) {
        var response = await movesStore.add(move)
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
        opponentMove.value = weightedRandom(await lichess.responses('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'))
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
        <select v-model="build">
            <option value="random">Weighted Random</option>
            <option value="mostViewed">Most Viewed</option>
          </select>
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
