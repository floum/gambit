# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w[ admin.js admin.css ]
Rails.application.config.assets.precompile += %w[bootstrap.min.js popper.js api.js chessground.js config.js state.js wrap.js events.js render.js autoPieces.js util.js svg.js board.js premove.js fen.js types.js anim.js drag.js draw.js explosion.js sync.js drop.js]
