require "httparty"

class NullMove
  def count
    0
  end
end

class LichessExplorerMove
  attr_accessor :count, :san, :uci

  def self.parse(response)
    move = LichessExplorerMove.new
    move.count = response['white'] + response['draws'] + response['black']
    move.san = response['san']
    move.uci = response['uci']
    move
  end
end

class LichessExplorerResponse
  attr_accessor :count
  attr_reader :moves

  def moves
    @moves ||= []
  end

  def self.parse(response)
    lichess_explorer_response = LichessExplorerResponse.new
    lichess_explorer_response.count = response['white'] + response['draws'] + response['black']
    response['moves'].each do |move|
      lichess_explorer_response.moves << LichessExplorerMove.parse(move)
    end

    lichess_explorer_response
  end

  def popularity(san)
    (moves.find { |move| move.san == san } || NullMove.new).count.to_f / count
  end
end

class LichessExplorer
  include HTTParty

  ENDPOINT = "https://explorer.lichess.ovh/lichess"

  def self.fetch(fen)
    response = HTTParty.get(ENDPOINT, query: {
      fen: fen,
      speeds: "blitz,rapid,classical",
      ratings: "2200,2500"
    })

    LichessExplorerResponse.parse(response.parsed_response)
  end
end

