import { defineStore } from 'pinia'
import { apiUrl } from '@/assets/api.js'

export const useRepertoireStore = defineStore('repertoire', {
    state: () => ({
        repertoires: []
    }),
    actions: {
        async get(id) {
            var repertoire = this.repertoires.find(repertoire => repertoire.id == id)
            if (!repertoire) {
                repertoire = await this.fetch(id)
                this.repertoires.push(repertoire)
            }
            return repertoire
        },
        async fetch(id) {
            const response = await fetch(`${apiUrl}/repertoires/${id}`)
            return await response.json()
        }
    }
})
