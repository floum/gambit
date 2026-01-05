<script setup>
import { ref, onMounted } from 'vue';
const emit = defineEmits(['selected'])

let studies = ref([]);

onMounted(async () => {
    const response = await fetch('http://192.168.1.22:3000/game_studies')
    studies.value = await response.json()
    console.log(studies)
})

const select = (id) => {
    console.log('Selected: '+ id)
    emit('selected', id)
}
</script>

<template>
    <table>
    <template v-for="study in studies">
        <tr>
        <td>{{ study.id }}</td>
        <td>{{ study.game_id }}</td>
        <td><button @click="select(study.id)">Select</button></td>
        </tr>
    </template>
    </table>
</template>