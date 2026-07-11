import { defineStore } from 'pinia'


export const useAlertStore = defineStore('alert', {
    state: () => {
        return {
            alert: null,
            type: null
        }
    }
})