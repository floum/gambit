<script setup>
import { ref, onMounted, computed } from 'vue';
const emit = defineEmits(['selected'])

let studies = ref([]);

onMounted(async () => {
    const response = await fetch('http://192.168.1.22:3000/game_studies')
    studies.value = await response.json()
})

const select = (id) => {
    emit('selected', id)
}

const gameNames = computed(() => {
    return studies.value.reduce((names, study)=> {
        names[study.id] = `${study.game.white} - ${study.game.black} ${study.game.result}`
        return names
    }, {})
})

</script>

<template>
    <table>
        <template v-for="study in studies">
            <tr>
                <td>{{ study.id }}</td>
                <td>{{ gameNames[study.id] }}</td>
                <td>{{ study.progress }}</td>
                <td><button class="btn-gambit" @click="select(study.id)">Select</button></td>
            </tr>
        </template>
    </table>
</template>