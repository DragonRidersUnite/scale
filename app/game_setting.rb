# different than the Settings scene, this module contains methods for things
# like fullscreen on/off, sfx on/off, etc.
module GameSetting
  class << self
    # returns a string of a hash of settings in the following format:
    # key1=val1,key2=val2
    # `settings` should be a hash of keys and vals to be saved
    def settings_for_save(settings)
      settings.map do |k, v|
        "#{k}:#{v}"
      end.join(",")
    end

    # we don't want to accidentally ship our debug preferences to our players
    def settings_file
      "settings#{ debug? ? '-debug' : nil}.txt"
    end

    # useful when wanting to save settings after the code in the block is
    # executed, ex: `GameSetting.save_after(args) { |args| args.state.setting.big_head_mode = true }
    def save_after(args)
      yield(args)
      save_settings(args)
    end

    # loads settings from disk and puts them into `args.state.setting`
    def load_settings(args)
      settings = args.gtk.read_file(settings_file)&.chomp

      if settings
        settings.split(",").map { |s| s.split(":") }.to_h.each do |k, v|
          if v == "true"
            v = true
          elsif v == "false"
            v = false
          end
          args.state.setting[k.to_sym] = v
        end
      else
        args.state.setting.sfx = true
        args.state.setting.fullscreen = false
      end

      if args.state.setting.fullscreen
        args.gtk.set_window_fullscreen(args.state.setting.fullscreen)
      end
    end

    # saves settings from `args.state.setting` to disk
    def save_settings(args)
      args.gtk.write_file(
        settings_file,
        settings_for_save(open_entity_to_hash(args.state.setting))
      )
    end
  end
end
