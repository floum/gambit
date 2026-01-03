<script setup>
import { ref } from 'vue'
let pgn = ref(null)

const save = async () => {
    const response = await fetch(
        'http://192.168.1.22:3000/games',
        {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ pgn: pgn.value })
        }
    )
    const data = await response.json()
}    
</script>

<template>
    <h2>Game Import</h2>
    <div>
        <textarea v-model="pgn" rows="25" cols="80"></textarea>
    </div>
    <div>
        <button class="btn-gambit" @click="save">Save</button>
    </div>
</template>