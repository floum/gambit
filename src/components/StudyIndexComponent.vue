<script setup>
import { ref, onMounted, computed } from 'vue';

let studies = ref([]);

onMounted(async () => {
    const response = await fetch('http://192.168.1.22:3000/game_studies')
    studies.value = await response.json()
})


const gameNames = computed(() => {
    return studies.value.reduce((names, study)=> {
        names[study.id] = `${study.game.white} - ${study.game.black} ${study.game.result}`
        return names
    }, {})
})

</script>

<template>
    <h2>Studies</h2>
    <table>
        <template v-for="study in studies">
            <tr>
                <td>{{ study.id }}</td>
                <td>{{ gameNames[study.id] }}</td>
                <td>{{ study.progress }}</td>
                <td><RouterLink class="btn-gambit" :to="{ name: 'studies.show', params: { id: study.id }}">Select</RouterLink></td>
            </tr>
        </template>
    </table>
</template>