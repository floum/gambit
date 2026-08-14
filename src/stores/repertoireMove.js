import { defineStore } from 'pinia'
import { apiUrl } from '@/assets/api.js'

export const useRepertoireMovesStore = defineStore('repertoire-moves', {
  state: () => ({
    repertoire: {},
    moves: [],
    filter: 'unknown',
    filters: ['unknown', 'rejected', 'confirmed']
  }),
  actions: {
    async create(data) {
      const response = await fetch(
        `${apiUrl}/repertoire_moves`,
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ 
            repertoire_move: {
              move: data.move,
              repertoire: { id: data.repertoire.id },
              status: 'unknown'
            }
          })
        }
      )
      return await response.json()
    },
    async add(move) {
      console.log('adding move to store:' + JSON.stringify(move))
      console.log(this.moves.length)
      const existingMove = this.moves.find((knownMove) => knownMove.before == move.before)
      if (existingMove) {
        return existingMove
      }
      const newMove = await createMove({move: move, repertoire: this.repertoire, status: "unknown"})
      this.moves.push(newMove)
      return newMove
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
