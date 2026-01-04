<script setup>
import { ref } from 'vue'
import 'vue3-chessboard/style.css';
import GamesComponent from './components/GamesComponent.vue';
import StudiesComponent from './components/StudiesComponent.vue';

let activeComponent = ref(GamesComponent)

const showGames = () => {
  activeComponent.value = GamesComponent
}

const study = () => {
  activeComponent.value = StudiesComponent
}

</script>

<template>
  <div class="navbar">
    <h1>Gambit</h1>
    <button class="btn-gambit" @click="study">Study</button>
    <button class="btn-gambit" @click="showGames">Games</button>
  </div>
  <component :is="activeComponent"></component>
</template>

<style>
body {
  background-color: black;
  color: white;
  text-align: center;
}

.navbar {
  padding: 10px;
  display: flex;
  align-items: left;
}

.btn-gambit {
  position: relative;
  padding: 16px 42px;
  background: linear-gradient(180deg, #0b0b0b, #1a1a1a);
  color: #e8dcd2;
  border: 2px solid #b89b5e;
  border-radius: 999px;
  font-family: 'Playfair Display', serif;
  font-size: 15px;
  letter-spacing: 1.2px;
  text-transform: uppercase;
  cursor: pointer;
  overflow: hidden;
  transition: all 0.4s ease;
}

.btn-small {
  font-size: 10px;
  padding: 12px 32px;
}

.btn-gambit::before {
  content: "";
  position: absolute;
  inset: 4px;
  border: 1px dashed rgba(184, 155, 94, 0.6);
  border-radius: 999px;
}

.btn-gambit:hover {
  color: #ffffff;
  box-shadow: 0 0 25px rgba(184, 155, 94, 0.5);
  transform: translateY(-2px);
}

#grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-gap: 10px;
}

#board {
  grid-column: 1 / 3;
}

#results {
  grid-column: 3;
}
</style>
