<script setup>
import { ref, onMounted } from 'vue';
const emit = defineEmits(['selected'])

let studies = ref([]);

onMounted(async () => {
    const response = await fetch('http://192.168.1.22:3000/game_studies')
    studies.value = await response.json()
})

const select = (id) => {
    emit('selected', id)
}

const gameName = (game) => {
    return `${game.white} - ${game.black} ${game.result}`
}
</script>

<template>
    <table>
    <template v-for="study in studies">
        <tr>
        <td>{{ study.id }}</td>
        <td>{{ gameName(study.game) }}</td>
        <td><button class="btn-gambit" @click="select(study.id)">Select</button></td>
        </tr>
    </template>
    </table>
</template>