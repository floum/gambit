const api_url = 'http://192.168.1.22:3000'

export const fetchGame = async (id) => {
    const response = await fetch(`${api_url}/games/${id}`)
    return await response.json()
}

export const createGame = async (data) => {
    const response = await fetch(
        `${api_url}/games`,
        {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                game: data
            })
        }
    )
    return response.status == 201
}

export const fetchStudy = async (id) => {
    const response = await fetch(`${api_url}/game_studies/${id}`)
    return await response.json()
}

export const fetchGames = async () => {
    const response = await fetch(`${api_url}/games`)
    return await response.json()
}