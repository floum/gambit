import { defineStore } from 'pinia'
import { apiUrl, createMove } from '@/assets/api.js'

export const useRepertoireMovesStore = defineStore('repertoire-moves', {
  state: () => ({
    repertoire: {},
    moves: [],
    filter: 'unknown',
    filters: ['unknown', 'rejected', 'confirmed']
  }),
  actions: {
    async add(move) {
        return await createMove({move: move, repertoire: this.repertoire})
    },
    async confirm(move) {
      return this.update(move, { status: "confirmed"})
    },
    async reject(move) {
      return this.update(move, {status: "rejected"})
    },
    async update(move, data) {
      const response = await fetch(
        `${apiUrl}/repertoire_moves/${move.id}`,
        {
          method: "PUT",
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: JSON.stringify({
            repertoire_move: data
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
