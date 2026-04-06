import { defineStore } from 'pinia'

import { bearer_token } from '@/config/app'
import { weightedRandom } from '@/assets/utils'

export const fetchLichessMoves = async (fen) => {
    const response = await fetch(
        `https://explorer.lichess.org/lichess?variant=standard&speeds=rapid,classical&ratings=1800,2000,2200,2500&fen=${fen}`,
        {
            method: "GET",
            headers: {
                "Authorization" : `Bearer ${bearer_token}`
            }
        })
    return await response.json()
}

export const lichessResponses = async (fen) => {
    var lichess = await fetchLichessMoves(fen)
    return lichess.moves.map((move) => { return {san: move.san, count: move.white + move.draws + move.black } }).sort((move1, move2) => (move2.count - move1.count))
}

export const useLichessResponseStore = defineStore('lichessResponse', {
    state: () => ({
        lichessFens: []
    }),
    actions: {
        async responses(fen) {
            var lichessFen = this.lichessFens.find(lichessResponses => lichessResponses.fen == fen)
            if (!lichessFen) {
                var responses = await lichessResponses(fen)
                this.lichessFens.push({
                    fen: fen,
                    responses: responses
                })
                return responses
            }
            return lichessFen.responses
        },
        async randomResponse(fen) {
            return await this.responses(fen)[Math.floor(Math.random()*this.responses.length)]
        },
        async mainResponse(fen) {
            return await this.responses(fen)[0]
        },
        async weightedRandomResponse(fen) {
            return weightedRandom(await this.responses(fen))
        }
    }
})


