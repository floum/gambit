<script setup>


const props = defineProps(['move'])
const emit = defineEmits(['result'])



const handleMove = (move) => {
    emit('result', {
        success: props.move.san == move.san,
        move: move
    })
}

const setPosition = (api) => {
    boardAPI = api
    boardAPI.setPosition(props.move.fen)
}
</script>

<template>
        
</template>