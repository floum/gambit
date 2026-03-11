<script setup>
import { ref, onMounted } from 'vue'
import { createRepertoire, fetchRepertoires } from '../../assets/api.js'

var repertoireName = ref('')
var repertoireColor = ref('white')
var repertoires = ref([])

const save = async () => {
    console.log(repertoireName)
    console.log(repertoireColor.value)
    await createRepertoire({
        name: repertoireName.value,
        white: repertoireColor.value == 'white'
    })
    repertoires.value = await fetchRepertoires()
}

onMounted(async () => {
    repertoires.value = await fetchRepertoires()
})

</script>


<template>
    <h2>Repertoires</h2>
    <div>
    <h3>New Repertoire</h3>
        <input v-model="repertoireName" />
        <input type="radio" v-model="repertoireColor" value="white" />
        <input type="radio" v-model="repertoireColor" value="black" />
        Color: {{ repertoireColor }}
        <button @click="save">Save</button>
    </div>
    <table>
        <thead>
            <tr>
                <td>Name</td>
                <td>Color</td>
            </tr>
        </thead>
        <tbody>
            <tr v-for="repertoire in repertoires">
                <td>{{ repertoire.name }}</td>
                <td>{{ repertoire.white ? 'white' : 'black' }}</td>
                <td><RouterLink :to="{ name: 'repertoires.practice', params: { id: repertoire.id } }" class="btn-gambit btn-small">Practice</RouterLink></td>
                <td><RouterLink :to="{ name: 'repertoires.show', params: { id: repertoire.id } }" class="btn-gambit btn-small">Show</RouterLink></td>
            </tr>
        </tbody>
    </table>
</template>