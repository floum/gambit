<script setup>
  import { ref, onMounted, computed } from 'vue';
import { TheChessboard } from 'vue3-chessboard';
import { fetchRepertoire, destroyRepertoireMove, confirmRepertoireMove } from '@/assets/api';
import { useAlertStore } from '@/stores/alert';
import { useRepertoireMovesStore } from '@/stores/repertoireMove';

const props = defineProps(['id'])

const movesStore = useRepertoireMovesStore()

var repertoire = ref(undefined)

var filters = ref({
    confirmed: true,
    box: true,
    crushing: false
})

onMounted(async () => {
    repertoire.value = await fetchRepertoire(props.id)
    movesStore.moves = repertoire.value.repertoire_moves
})

const visible = computed(() => {
    if (!repertoire.value) {
        return []
    }
    return repertoire.value.repertoire_moves.filter(move => !move.status == "confirmed")
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
        if (response.status < 400) {
        const alertStore = useAlertStore()
        alertStore.alert = 'Move successfully destroyed.'
        alertStore.type = 'success'
    }
}

const confirm = async (move) => {
    return await movesStore.confirm(move)
}

const reject = async (repertoireMove) => {
    var result = await movesStore.reject(repertoireMove)
    console.log(result)
}
</script>

<template>
  <div v-if="repertoire">
    <h2>Repertoire: {{ repertoire.name }}</h2>
    <h3>Moves : {{ movesStore.moves.length }}</h3>
    <h4>Showing: {{ movesStore.filteredMoves.length }}</h4>
    <div class="repertoire-moves-filters">
      Status: 
      <select v-model="movesStore.filter" >
        <template v-for="filter in movesStore.filters">
          <option :value="filter">
          {{ filter }}
          </option>
        </template>
      </select>
    </div>
    <div class="repertoire-moves-grid">
      <template v-for="repertoireMove in movesStore.filteredMoves">
        <div class="repertoire-move-board">
          <TheChessboard class="chessboard"
                         @board-created="(api) => (setBoard(api, repertoireMove))" />
        </div>
        <div>
          <div>{{ repertoireMove.san }}</div>
          <div>{{ repertoireMove.status }}</div>
          <div><a :href="'https://lichess.org/analysis/' + repertoireMove.fen" target="_blank">Lichess</a>
          </div>
          <div>
            <button class="btn-gambit btn-small" @click="confirm(repertoireMove)">Confirm</button>
            <button class="btn-gambit btn-small" @click="reject(repertoireMove)">Reject</button>
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
