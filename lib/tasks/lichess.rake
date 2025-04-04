namespace :lichess do
  desc 'Scan a repertoire'
  task :scan, [:id] => :environment do |t, args|
    id = args[:id].to_i
    repertoire = Repertoire.find(id)
    repertoire.moves.each do |move|
      p move
      p LichessExplorer.fetch(move.before)
      break
    end
  end
end
