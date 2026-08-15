<script setup>
  import { ref, onMounted, computed } from 'vue';
import { TheChessboard } from 'vue3-chessboard';
import RepertoireMoveComponent from '@/components/Repertoires/RepertoireMoveComponent.vue'
import { fetchRepertoire } from '@/assets/api';
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
    <div class="repertoire-moves">
      <div class="row">
      <template v-for="repertoireMove in movesStore.filteredMoves">
        <div class="col-4">
        <div class="repertoire-move">
          <RepertoireMoveComponent :repertoireMove="repertoireMove" />
        </div>
        </div>
      </template>
      </div>
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
