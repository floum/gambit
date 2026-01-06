<script setup>
import { computed } from 'vue'

const props = defineProps(['study'])
const matches = computed(() => {
    return props.study.expected_moves.reduce((count, expected_move, index)=> {
        return count + (expected_move.san == props.study.game_study_moves[index].san ? 1 : 0)
    }, 0)
})

</script>

<template>
    <div>Results</div>
    <div>Matches : {{ matches }}</div>
    <div>Submitted</div>
    <template v-for="move in props.study.game_study_moves">
        <span>{{ move.san }} - </span>
    </template>
    <div>Expected</div>
    <template v-for="move in props.study.expected_moves">
        <span>{{ move.san }} - </span>
    </template>
</template>
