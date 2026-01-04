<script setup>
import { ref } from 'vue'
import { Chess } from 'chess.js'
let pgn = ref(null)
let game = new Chess()

const save = async () => {
    game.loadPgn(pgn.value)
    let headers = game.getHeaders()
    console.log(headers)
    let history = game.history({ verbose: true })
    const response = await fetch(
        'http://192.168.1.22:3000/games',
        {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                game: {
                    pgn: pgn.value,
                    moves: history,
                    white: headers.White,
                    black: headers.Black,
                    played: headers.Date,
                    result: headers.Result
                 }
            })
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