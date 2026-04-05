<script setup>
import { ref, onMounted, computed } from 'vue';
import { TheChessboard } from 'vue3-chessboard';
import { fetchRepertoire, destroyRepertoireMove, confirmRepertoireMove } from '@/assets/api';

const props = defineProps(['id'])

var repertoire = ref(undefined)
var size = ref(0)

var filters = ref({
    confirmed: true,
    box: true,
    crushing: false
})

onMounted(async () => {
    repertoire.value = await fetchRepertoire(props.id)
    size.value = repertoire.value.repertoire_moves.length
})

const visible = computed(() => {
    if (!repertoire.value) {
        return []
    }
    return repertoire.value.repertoire_moves.filter(move => !move.confirmed)
})

const setBoard = (api, repertoireMove) => {
    var config = {
        fen: repertoireMove.fen
    }
    if (!repertoire.value.white) {
        config.orientation = 'black'
    }
    api.setConfig(config)
}

const destroy = async (repertoireMove) => {
    var response = await destroyRepertoireMove(repertoireMove)
}

const confirm = async (repertoireMove) => {
    var response = await confirmRepertoireMove(repertoireMove)
}
</script>

<template>
<div v-if="repertoire">
    <h2>Repertoire: {{ repertoire.name }}</h2>
    <h3>Moves : {{ size }}</h3>
    <div class="repertoire-moves-grid">
        <template v-for="repertoireMove in visible">
            <div class="repertoire-move-board">
                <TheChessboard class="chessboard"
                    @board-created="(api) => (setBoard(api, repertoireMove))" />
            </div>
            <div>
                <div>{{ repertoireMove.san }}</div>
                <div>{{ repertoireMove.box }} - {{ repertoireMove.crushing }}</div>
                <div><a :href="'https://lichess.org/analysis/' + repertoireMove.fen" target="_blank">Lichess</a>
                </div>
                <div>
                    <button class="btn-gambit btn-small" @click="confirm(repertoireMove)">Confirm</button>
                    <button class="btn-gambit btn-danger btn-small" @click="destroy(repertoireMove)">Remove</button>
                </div>
            </div>    
        </template>
    </div>
</div>
</template>

<style>
.repertoire-moves-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-gap: 16px;
}
.chessboard {
    max-width: 40vh !important;
}
</style>