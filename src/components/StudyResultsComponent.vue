<script setup>
import { computed } from 'vue'
import SuccessComponent from './SuccessComponent.vue'

const props = defineProps(['study'])

console.log(props.study.game_study_moves)
const matches = computed(() => {
    return props.study.expected_moves.reduce((count, expected_move, index)=> {
        return count + (expected_move.san == props.study.game_study_moves[index].san ? 1 : 0)
    }, 0)
})

const moves = computed(() => {
    return props.study.expected_moves.map((expected_move, index) => {
        return {
            expected: expected_move,
            submitted: props.study.game_study_moves[index]
        }
    })
})

const success = (move) => {
    return move.expected.san == move.submitted.san
}

</script>

<template>
    <div>Results</div>
    <div>Matches : {{ matches }}</div>
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
                <td><SuccessComponent v-if="success(move)"></SuccessComponent></td>
            </tr>
        </template>
    </table>
</template>
