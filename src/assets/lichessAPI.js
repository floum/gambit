const bearer_token = import.meta.env.VITE_LICHESS_TOKEN

const fetchLichessMoves = async (fen) => {
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

export const lichessMoves = async (fen) => {
    var lichess = await fetchLichessMoves(fen)
  console.log(lichess)
    const responses = lichess.moves.map((move) => { return {san: move.san, count: move.white + move.draws + move.black } }).sort((move1, move2) => (move2.count - move1.count))
  return responses
}
