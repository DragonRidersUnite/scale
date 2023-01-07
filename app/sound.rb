def play_sfx(args, key)
  if args.state.setting.sfx
    args.outputs.sounds << "sounds/#{key}.wav"
  end
end
