import { defineStore } from 'pinia'
import { apiUrl } from '@/assets/api.js'
import { useRepertoireMovesStore } from '@/stores/repertoireMove'

export const useRepertoireStore = defineStore('repertoire', {
    state: () => ({
        repertoire: {},
    }),
    actions: {
        async load(id) {
          const response = await fetch(`${apiUrl}/repertoires/${id}`)
          this.repertoire = await response.json()
        },
        async add(move) {
          const existing = this.moves.find(known => known.fen == move.before && known.san == move.san)
          if (existing) {
            console.log("EXISTING MOVE")
            if (existing.status == "rejected") {
              console.log("REJECTED MOVE")
              return false
            }
            return true
          }
          const movesStore = useRepertoireMovesStore()
          const newMove = await movesStore.create({repertoire: this.repertoire, move: move})
          if (newMove) {
            this.moves.push(newMove)
          }
          return true
        },
    },
    getters: {
      white: (state) => state.repertoire.white,
      name: (state) => state.repertoire.name,
      color: (state) => state.repertoire.white ? 'w' : 'b',
      moves: (state) => state.repertoire.repertoire_moves,
    }
})
