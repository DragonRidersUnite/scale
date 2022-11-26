TRUE_BLACK = [255, 255, 255]

def debug?
  !!$gtk.production
end

def tick args
  args.outputs.debug << [args.grid.w - 12, args.grid.h, "#{args.gtk.current_framerate.round}", 0, 1, *TRUE_BLACK].label
end
