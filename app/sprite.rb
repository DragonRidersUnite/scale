module Sprite
  # annoying to track but useful for reloading with +i+ in debug mode; would be
  # nice to define a different way
  SPRITES = {
    bullet: "sprites/bullet.png",
    enemy: "sprites/enemy.png",
    enemy_king: "sprites/enemy_king.png",
    enemy_super: "sprites/enemy_super.png",
    exp_chip: "sprites/exp_chip.png",
    familiar: "sprites/familiar.png",
    player: "sprites/player.png",
  }

  class << self
    def reset_all(args)
      SPRITES.each { |_, v| args.gtk.reset_sprite(v) }
    end

    def for(key)
      SPRITES.fetch(key)
    end
  end
end

