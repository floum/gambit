<script setup>
import { ref, computed } from 'vue'
import { TheChessboard } from 'vue3-chessboard'

const props = defineProps(['study'])
let boardConfig = {}
let boardAPI
let currentMove = ref(null)

const moves = computed(() => {
    return props.study.expected_moves.map((expected_move, index) => {
        return {
            expected: expected_move,
            submitted: props.study.game_study_moves[index]
        }
    })
})

const difference = (move) => {
    return Math.round((move.submitted.evaluation - move.expected.evaluation) * 100) / 100
}

const view = (move) => {
    currentMove.value = move
    if (boardAPI) {
        boardAPI.setPosition(currentMove.value.expected.before)
    }
}

const loadBoard = (api) => {
    boardAPI = api
    boardAPI.setPosition(currentMove.value.expected.before)
}

const moveClass = (move) => {
    if (difference(move) < - 1) {
        return 'blunder'
    }
    return ''
}
</script>

<template>
    <div>Results</div>
    <div>
        <div id="move-results">
            <div class="move-results__header">
                <div>GM</div>
                <div>Eval</div>
                <div>diff</div>
                <div>You</div>
            </div>
            <template v-for="move in moves">
                <div class="move-results__move">
                    <div><button class="btn-gambit" @click="view(move)">{{ move.expected.san }}</button></div>
                    <div>{{ move.expected.evaluation }}</div>
                    <div :class="moveClass(move)">{{ difference(move) }}</div>
                    <div>{{ move.submitted.san }}</div>
                </div>
            </template>
        </div>
    </div>
    <div>
        <div v-if="currentMove">
            <TheChessboard @board-created="loadBoard" :board-config="boardConfig" />
        </div>
    </div>
</template>

<style>
#move-results {
    display: flex;
    overflow: scroll;
}

.move-results__header {
    font-weight: bold;
}

.move-results__move {
    padding-left: 16px;
}

.blunder {
    color: red;
}
</style>