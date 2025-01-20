require "httparty"
require "debug"

module Lichess
  class Player
    def initialize(name)
      @name = name
    end
  end

  class Game
    attr_reader :clocks

    def self.parse(json, options = {})
      data = JSON.parse(json)
      clocks = data["clocks"]
      binding.break
      Game.new(clocks: clocks, increment: data["clock"]["increment"] * 100)
    end

    def initialize(attrs = {})
      @clocks = attrs.fetch(:clocks, [])
      @increment = attrs.fetch(:increment, 0)
    end

    def white_clocks
      @clocks.each_slice(2).map(&:first)
    end

    def white_time_usage
      white_clocks.each_cons(2).map { |t1, t2| (t1 - t2 + @increment) / 100.0 }
    end

    def black_clocks
      @clocks.each_slice(2).map(&:last)
    end

    def black_time_usage
      black_clocks.each_cons(2).map { |t1, t2| (t1 - t2 + @increment) / 100.0 }
    end
  end
end

class LichessGames
  include HTTParty

  ENDPOINT = "https://lichess.org/game/export/"

  def self.fetch(game_id, options = {})
    response = HTTParty.get(
      ENDPOINT << game_id,
      headers: { "Accept" => "application/json" }
    )

    Lichess::Game.parse(response.body, options)
  end
end
