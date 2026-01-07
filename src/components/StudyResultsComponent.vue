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
    return move.submitted.evaluation - move.expected.evaluation
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
</script>

<template>
    <div>Results</div>
    <div id="grid">
        <div id="board">
            <div v-if="currentMove">
                <TheChessboard @board-created="loadBoard" :board-config="boardConfig" />
                <div>Played : {{ currentMove.expected.san }}</div>
                <div>Submitted : {{ currentMove.submitted.san }}</div>
            </div>
        </div>
        <table>
            <thead>
                <th>GM Move</th>
                <th>evaluation</th>
                <th>Your Move</th>
                <th>evaluation</th>
            </thead>
            <template v-for="move in moves">
                <tr>
                    <td>{{ move.expected.san }}</td>
                    <td>{{ move.expected.evaluation }}</td>
                    <td>{{ move.submitted.san }}</td>
                    <td>{{ move.submitted.evaluation }}</td>
                    <td>{{ difference(move) }}</td>
                    <td><button @click="view(move)">View</button></td>
                    <td></td>
                </tr>
            </template>
        </table>
    </div>
</template>
