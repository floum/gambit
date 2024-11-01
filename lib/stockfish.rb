require 'pty'

class Stockfish
  def initialize
    @engine = %x(which stockfish).strip
  end

  def compute_move(fen, move)
    PTY.open do |master, slave|
      read, write = IO.pipe
      pid = spawn(@engine, in: read, out: slave)
      write.puts("position fen #{fen} moves #{move}")
      write.puts("d")
      while line = master.gets
        return line.strip[5..] if line[/Fen/]
      end
    end
  end
end

