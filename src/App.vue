<script setup>
import 'vue3-chessboard/style.css';
</script>

<template>
  <div class="navbar">
    <h1 class="nav-title">Gambit</h1>
    <RouterLink :to="{ name: 'studies.index' }" class="btn-gambit">Studies</RouterLink>
    <RouterLink :to="{ name: 'games.index' }" class="btn-gambit">Games</RouterLink>
  </div>
  <RouterView></RouterView>
</template>

<style>
body {
  background-color: black;
  color: white;
  text-align: center;
}

.navbar {
  padding: 10px;
  display: inline;
}

.nav-title {
  display: inline;
}

.btn-gambit {
  padding: 10px 18px;
  border: none;
  border-radius: 6px;
  background: #111;
  color: #fff;
  font-size: 14px;
  cursor: pointer;
  transition: 0.2s ease;
}

.btn-small {}

.btn-gambit::before {}

.btn-gambit:hover {
  background: #333;
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
