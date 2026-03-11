const bearer_token = process.env.LICHESS_TOKEN
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

export const createRepertoire = async (data) => {
    const response = await fetch(
        `${api_url}/repertoires`,
        {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                repertoire: data
            })
        }
    )
    return response.status == 201
}

export const fetchRepertoire = async (id) => {
    const response = await fetch(`${api_url}/repertoires/${id}`)
    return await response.json()
}

export const fetchRepertoires = async () => {
    const response = await fetch(`${api_url}/repertoires`)
    return await response.json()
}

function weightedRandom(items) {
  const totalWeight = items.reduce((sum, item) => sum + item.count, 0);
  let r = Math.random() * totalWeight;

  for (const item of items) {
    r -= item.count;
    if (r <= 0) {
      return item;
    }
  }
}

export const randomMasterResponse = async (fen) => {
    var masters = await fetchMasters(fen)
    console.log(masters)
    var moves = masters.moves.map((move) => { return {san: move.san, count: move.white + move.draws + move.black } })
    return weightedRandom(moves)
}

export const fetchMasters = async (fen) => {
    const response = await fetch(
        `https://explorer.lichess.org/masters?fen=${fen}`,
        {
            method: "GET",
            headers: {
                "Authorization" : `Bearer ${bearer_token}`
            }
        })
    return await response.json()
}

export const fetchLichessMoves = async (fen) => {
    const response = await fetch(
        `https://explorer.lichess.org/lichess?variant=standard&speeds=blitz,rapid&ratings=2000,2200,2500&fen=${fen}`,
        {
            method: "GET",
            headers: {
                "Authorization" : `Bearer ${bearer_token}`
            }
        })
    return await response.json()
}

export const randomLichessResponse = async (fen) => {
    var lichess = await fetchLichessMoves(fen)
    console.log(lichess)
    var moves = lichess.moves.map((move) => { return {san: move.san, count: move.white + move.draws + move.black } })
    return weightedRandom(moves)
}

export const createMove = async (data) => {
    const response = await fetch(
        `${api_url}/repertoire_moves`,
        {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ 
                repertoire_move: {
                    move: data.move,
                    repertoire: data.repertoire
                }
            })
        }
    )
    return response.status
}

export const destroyRepertoireMove = async (data) => {
     const response = await fetch(
        `${api_url}/repertoire_moves/${data.id}`,
        {
            method: "DELETE"
        }
    )
    return response.status == 204   
}

export const confirmRepertoireMove = async (data) => {
    const response = await fetch(
        `${api_url}/repertoire_moves/${data.id}`,
        {
            method: "PUT",
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify({
                repertoire_move: {
                    confirmed: true
                }
            })
        }
    )
    return response.status < 400
}
