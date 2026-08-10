import { defineStore } from 'pinia'

const bearer_token = import.meta.env.VITE_LICHESS_TOKEN

import { weightedRandom } from '@/assets/utils'
import { lichessMoves } from '@/assets/lichessAPI';

export const useLichessStore = defineStore('lichessResponse', {
    state: () => ({
        positions: []
    }),
    actions: {
        async moves(fen) {
            var existing = this.positions.find(position => position.fen == fen)
            if (existing) {
              return existing.moves
            }
            var moves = await lichessMoves(fen)
            this.positions.push({
              fen: fen,
              moves: moves
            })
            return moves
        },
        async random(fen) {
          const moves = await this.moves(fen)
          const result = moves[Math.floor(Math.random()*moves.length)]
          console.log(`Lichess Random: ${result.san}`)
          return result
        },
        async main(fen) {
          const moves = await this.moves(fen)
          const result = moves[0]
          console.log(`Lichess Main: ${result}`)
          return result
        },
        async weighted(fen) {
          const moves = await this.moves(fen)
          const result = weightedRandom(moves)
          console.log(`Lichess Weighted: ${result}`)
          return result
        }
    }
})


