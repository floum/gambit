import { defineStore } from 'pinia'

export const useRepertoireMovesStore = defineStore('repertoire-moves', {
  state: () => ({
    moves: [],
    filter: 'unknown',
    filters: ['unknown', 'rejected', 'confirmed']
  }),
  getters: {
    unknownMoves(state) {
      return state.moves.filter((move) => move.status == "unknown")
    },
    rejectedMoves(state) {
      return state.moves.filter((move) => move.status == "rejected")
    },
    filteredMoves(state) {
      return state.moves.filter(move => move.status == state.filter)
    },
  }
})
