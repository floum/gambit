<script setup>
import { ref, onMounted } from 'vue';
import { TheChessboard } from 'vue3-chessboard';
import { fetchRepertoire, destroyRepertoireMove, confirmRepertoireMove } from '@/assets/api';

const props = defineProps(['id'])

var repertoire = ref({})
var confirmed = ref(false)

onMounted(async () => {
    repertoire.value = await fetchRepertoire(props.id)
    if (!repertoire.value.white) {
        boardAPI.setConfig({
            orientation: 'black'
        })
    }
})

const destroy = async (repertoireMove) => {
    var response = await destroyRepertoireMove(repertoireMove)
}

const confirm = async (repertoireMove) => {
    var response = await confirmRepertoireMove(repertoireMove)
}

</script>
<template>
    <h2>Repertoire: {{ repertoire.name }}</h2>
    <h3>Moves</h3>
    <div class="repertoire-move-grid">
    <div class="repertoire-move" v-for="repertoireMove in repertoire.repertoire_moves">
        <template v-if="showConfirmed || !repertoireMove.confirmed">
            <div><TheChessboard class="chessboard" @board-created="(api) => (api.setConfig({ fen: repertoireMove.fen }))" /></div>
            <div>{{ repertoireMove.san }}</div>
            <div><a :href="'https://lichess.org/analysis/' + repertoireMove.fen" target="_blank">Lichess</a></div>
            <div>
                <button class="btn-gambit btn-small" @click="confirm(repertoireMove)">Confirm</button>
                <button class="btn-gambit btn-danger btn-small" @click="destroy(repertoireMove)">Remove</button>
            </div>
        </template>
    </div>
</div>
</template>

<style>
.chessboard {
    max-width: 25vh !important;
}
</style>