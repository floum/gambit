<script setup>
import { TheChessboard } from 'vue3-chessboard';

const props = defineProps(['moves'])

const emit = defineEmits(['answer'])

var index = 0
var boardAPI

const handleMove = (move) => {
    var expected_move = props.moves[index]

    emit('answer', {
        move: move,
        expectedMove: expected_move,
        success: expected_move.san == move.san
    })
}

const next = () => {
    index++
    if (index < props.moves.length) {
        boardAPI.setPosition(props.moves[index].fen)
    }
}

</script>

<template>
    <template v-if="index < props.moves.length">
        <TheChessboard @board-created="(api) => (boardAPI = api)" @move="handleMove"></TheChessboard>
        <button @click="next">Next</button>
    </template>
</template>