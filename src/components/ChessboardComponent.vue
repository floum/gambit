<script setup>
import { Chessground } from '@lichess-org/chessground';
import { ref, onMounted } from 'vue';

const chessboard = ref(null)

onMounted(() => {
    const config = {}
    const ground = Chessground(this.$refs.chessboard, config)
})
</script>

<template>
  <div ref="chessboard">Loading...</div>
</template>