<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRepertoireStore } from '@/stores/repertoire';
import { TheChessboard } from 'vue3-chessboard';
import { sleep } from '@/assets/utils';

var boardAPI
const index = ref(0)

const repertoireStore = useRepertoireStore()

const loading = ref(true)
const repertoire = ref({})
const expected_moves = ref([])
const filter = ref('all')

const props = defineProps(['id'])

const failed_moves = ref([])

onMounted(async () => {
    repertoire.value = await repertoireStore.get(props.id)
    expected_moves.value = repertoire.value.repertoire_moves.filter(repertoire_move => repertoire_move.box)
    loading.value = false
})

const handleMove = async (move) => {
    if (current.value.san != move.san) {
        handleFailure()
    } else {
        console.log('success')
    }

    if (index.value == expected_moves.value.length - 1) {
        console.log('resetting')
        expected_moves.value = failed_moves.value
        failed_moves.value = []
        index.value = 0
    } else {
        index.value++
    }
    await sleep(500)
    if (expected_moves.value.length > 0) {
        boardAPI.setPosition(current.value.fen)
    }
}

const handleFailure = () => {
    console.log('failure')
    failed_moves.value.push(current.value)
}

const current = computed(() => {
  return expected_moves.value[index.value]
})

const boardCreated = (api) => {
    boardAPI = api
    boardAPI.setConfig({orientation: (repertoire.value.white ? 'white' : 'black') })
    boardAPI.setPosition(current.value.fen)
}

</script>

<template>
    <template v-if="!loading">
        <h2>{{ repertoire.name }} | Practicing {{ expected_moves.length }} Moves | Failed: {{ failed_moves.length }}</h2>
          <select v-model="filter">
            <option value="all">All</option>
            <option value="boxes">Boxes</option>
          </select>
        <template v-if="expected_moves.length > 0">
            <TheChessboard @board-created="boardCreated" @move="handleMove"></TheChessboard>
        </template>
        <template v-else>
            <h3>Practice finished!</h3>
        </template>
    </template>
</template>

<style>

.boxes-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-gap: 16px;
}

.box-answer-correct {
    color: green;
}

</style>