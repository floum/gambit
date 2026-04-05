<script setup>
import { ref, onMounted, computed } from 'vue'
import MoveTrainerComponent from '../MoveTrainerComponent.vue'
import { useRepertoireStore } from '@/stores/repertoire';

const repertoireStore = useRepertoireStore()

const loading = ref(true)
const repertoire = ref({})
const repertoire_moves = ref([])
const filter = ref('all')

const props = defineProps(['id'])

onMounted(async () => {
    repertoire.value = await repertoireStore.get(props.id)
    repertoire_moves.value = repertoire.value.repertoire_moves
    console.log(repertoire_moves.value)
    loading.value = false
})

const handleAnswer = (answer) => {
    console.log(answer)
}

const practiced = computed(() => {
  if (filter.value == 'all') { 
    return repertoire_moves.value 
    }
  if (filter.value == 'boxes') {
    return repertoire_moves.value.filter(repertoire_move => repertoire_move.box)
  }
})

</script>

<template>
    <template v-if="!loading">
        <h2>{{ repertoire.name }} | Practicing {{ practiced.length }} Moves</h2>
          <select v-model="filter">
            <option value="all">All</option>
            <option value="boxes">Boxes</option>
          </select>

        <MoveTrainerComponent :moves="practiced" @answer="handleAnswer"></MoveTrainerComponent>
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