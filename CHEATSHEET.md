# DragonRuby GTK Cheatsheet

Quick reference for common data structures and methods. This cheatsheet prefers hashes for the data structure when using DRGTK.

Supplemental to [the official docs](https://docs.dragonruby.org).

## Get Tick Count

``` ruby
args.state.tick_count
```

## Render Label

``` ruby
args.outputs.labels << {
  x:                       200,
  y:                       550,
  text:                    "dragonruby",
  size_enum:               2,
  alignment_enum:          1,
  r:                       155,
  g:                       50,
  b:                       50,
  a:                       255,
  font:                    "fonts/manaspc.ttf",
  vertical_alignment_enum: 0, # 0 is bottom, 1 is middle, 2 is top
}
```

## Play Sound Effect

``` ruby
args.outputs.sounds << 'something.wav'
```
