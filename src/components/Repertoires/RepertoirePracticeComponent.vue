<script setup>
import { ref, onMounted } from 'vue'
import { loadBoxes, loadCrushing } from '@/assets/api'
import MoveTrainerComponent from '../MoveTrainerComponent.vue'

var boxes = ref({})
var crushing = ref({})
var index = ref(0)
var answers = ref([])
var fen = ref('')
var boardAPI

const props = defineProps(['id'])

onMounted(async () => {
    boxes.value = await loadBoxes(props.id)
    crushing.value = await loadCrushing(props.id)
    
})

</script>

<template>
    <h2>{{ repertoire.name }}</h2>
    <MoveTrainerComponent :moves="boxes" @move=""></MoveTrainerComponent>
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