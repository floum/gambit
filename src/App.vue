<script setup>
import {ref } from 'vue'
import 'vue3-chessboard/style.css';
import GameComponent from './components/GameComponent.vue';
import PuzzleComponent from './components/PuzzleComponent.vue';
import PuzzleCreatorComponent from './components/PuzzleCreatorComponent.vue';

let activeComponent = ref(PuzzleComponent)

const showPuzzle = () => {
  activeComponent.value = PuzzleComponent
}

const showGame = () => {
  activeComponent.value = GameComponent
}

const showPuzzleCreator = () => {
  activeComponent.value = PuzzleCreatorComponent
}
</script>

<template>
  <h1>Gambit</h1>
  <div id="navbar">
    <button class="btn-gambit" @click="showPuzzle">Puzzle</button>
    <button class="btn-gambit" @click="showPuzzleCreator">Puzzle Creator</button>
    <button class="btn-gambit" @click="showGame">Game Import</button>
  </div>
  <component :is="activeComponent"></component>
</template>

<style>
  body {
    background-color: black;
    color: white;
    text-align: center;
  }
  #navbar {
    padding: 10px;
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
</style>
