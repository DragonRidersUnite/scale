# efficient input helpers that all take `args.inputs`

PRIMARY_KEYS = [:j, :z, :space]
def primary_down?(inputs)
  PRIMARY_KEYS.any? { |k| inputs.keyboard.key_down.send(k) } ||
    inputs.controller_one.key_down&.a
end
def primary_down_or_held?(inputs)
  primary_down?(inputs) ||
    PRIMARY_KEYS.any? { |k| inputs.keyboard.key_held.send(k) } ||
    (inputs.controller_one.connected &&
     inputs.controller_one.key_held.a)
end

SECONDARY_KEYS = [:k, :x, :backspace]
def secondary_down?(inputs)
  SECONDARY_KEYS.any? { |k| inputs.keyboard.key_down.send(k) } ||
    (inputs.controller_one.connected &&
      inputs.controller_one.key_down.b)
end
def secondary_down_or_held?(inputs)
  secondary_down?(inputs) ||
    SECONDARY_KEYS.any? { |k| inputs.keyboard.key_held.send(k) } ||
    (inputs.controller_one.connected &&
     inputs.controller_one.key_held.b)
end

PAUSE_KEYS= [:escape, :p]
def pause_down?(inputs)
  PAUSE_KEYS.any? { |k| inputs.keyboard.key_down.send(k) } ||
    inputs.controller_one.key_down&.start
end
