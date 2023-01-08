# play a sound effect. the file in sounds/ must match the key name. ex:
# play_sfx(args, :select)
def play_sfx(args, key)
  if args.state.setting.sfx
    args.outputs.sounds << "sounds/#{key}.wav"
  end
end
