import { defineStore } from 'pinia'
import { apiUrl } from '@/assets/api.js'

export const useRepertoireMovesStore = defineStore('repertoire-moves', {
  state: () => ({
    moves: [],
    filter: 'unknown',
    filters: ['unknown', 'rejected', 'confirmed']
  }),
  actions: {
    async reject(move) {
      const response = await fetch(
        `${apiUrl}/repertoire_moves/${move.id}`,
        {
          method: "PUT",
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: JSON.stringify({
            repertoire_move: {
              status: 'rejected'
            }
          })
        }
      )
      return response.status < 400
    },
  },
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
