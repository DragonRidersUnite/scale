# To run the tests: ./run_tests
#
# Available assertions:
# assert.true!
# assert.false!
# assert.equal!
#
# View more details: https://github.com/DragonRidersUnite/dragon_test

return unless debug?

def run_tests
  $gtk.tests&.passed.clear
  $gtk.tests&.inconclusive.clear
  $gtk.tests&.failed.clear
  puts "running tests"
  $gtk.reset 100
  $gtk.log_level = :on
  $gtk.tests.start

  if $gtk.tests.failed.any?
    puts "🙀 tests failed!"
    failures = $gtk.tests.failed.uniq.map do |failure|
      "🔴 ##{failure[:m]} - #{failure[:e]}"
    end

    if $gtk.cli_arguments.keys.include?(:"exit-on-fail")
      $gtk.write_file("test-failures.txt", failures.join("\n"))
      exit(1)
    end
  else
    puts "🪩 tests passed!"
  end
end

# an optional BDD-like method to use to group and document tests
def it(message)
  yield
end

def test(method)
  test_name = "test_#{method}"
  define_method(test_name) do |args, assert|
    # define custom assertions here!
    # assert.define_singleton_method(:rect!) do |obj|
    #   assert.true!(obj.x && obj.y && obj.w && obj.h, "doesn't have needed properties")
    # end
    assert.define_singleton_method(:exception!) do |lamb, error_class, message|
      begin
        lamb.call(args)
      rescue StandardError => e
        assert.equal!(e.class, error_class)
        assert.equal!(e.message, message)
      end
    end

    yield(args, assert)
  end
end

test :menu_text_for_setting_val do |args, assert|
  assert.equal!(Menu.text_for_setting_val(true), "ON")
  assert.equal!(Menu.text_for_setting_val(false), "OFF")
  assert.equal!(Menu.text_for_setting_val("other"), "other")
end

test :out_of_bounds do |args, assert|
  grid = {
    x: 0,
    y: 0,
    w: 1280,
    h: 720,
  }
  assert.true!(out_of_bounds?(grid, { x: -30, y: 30, w: 24, h: 24 }))
  assert.true!(out_of_bounds?(grid, { x: 30, y: -50, w: 24, h: 24 }))
  assert.false!(out_of_bounds?(grid, { x: 30, y: 30, w: 24, h: 24 }))
end

test :angle_for_dir do |args, assert|
  assert.equal!(angle_for_dir(DIR_RIGHT), 0)
  assert.equal!(angle_for_dir(DIR_LEFT), 180)
  assert.equal!(angle_for_dir(DIR_UP), 90)
  assert.equal!(angle_for_dir(DIR_DOWN), 270)
end

test :vel_from_angle do |args, assert|
  it "calculates core four angles properly" do
    assert.equal!(vel_from_angle(0, 5), [5.0, 0.0])
    assert.equal!(vel_from_angle(90, 5).map { |v| v.round(2) }, [0.0, 5.0])
    assert.equal!(vel_from_angle(180, 5).map { |v| v.round(2) }, [-5.0, 0.0])
    assert.equal!(vel_from_angle(270, 5).map { |v| v.round(2) }, [0.0, -5.0])
  end

  it "calculates other values as expected" do
    assert.equal!(vel_from_angle(12, 5).map { |v| v.round(2) }, [4.89, 1.04])
  end
end

test :open_entity_to_hash do |args, assert|
  it "strips OpenEntity keys" do
    args.state.foo.bar = true
    args.state.foo.biz = false
    assert.equal!(open_entity_to_hash(args.state.foo), { bar: true, biz: false })
  end
end

test :game_setting_settings_for_save do |args, assert|
  it "joins hash keys and values" do
    assert.equal!(GameSetting.settings_for_save({ fullscreen: true, sfx: false}), "fullscreen:true,sfx:false")
  end
end

test :text do |args, assert|
  it "returns the value for the passed in key" do
    assert.equal!(text(:fullscreen), "Fullscreen")
  end

  it "raises when the key isn't present" do
    assert.exception!(-> (_) { text(:not_present) }, KeyError, "Key not found: :not_present")
  end
end

test :opposite_angle do |args, assert|
  it "returns the diametrically opposed angle" do
    assert.equal!(opposite_angle(0), 180)
    assert.equal!(opposite_angle(180), 0)
    assert.equal!(opposite_angle(360), 180)
    assert.equal!(opposite_angle(90), 270)
    assert.equal!(opposite_angle(270), 90)
  end
end

test :add_to_angle do |args, assert|
  it "returns the new angle on the circle" do
    assert.equal!(add_to_angle(0, 30), 30)
    assert.equal!(add_to_angle(0, -30), 330)
    assert.equal!(add_to_angle(180, -30), 150)
    assert.equal!(add_to_angle(320, 60), 20)
    assert.equal!(add_to_angle(320, -60), 260)
  end
end

test :percent_chance? do |args, assert|
  it "returns false if the percent is 0" do
    assert.false!(percent_chance?(0))
  end

  it "returns true if the percent is 100" do
    assert.true!(percent_chance?(100))
  end

  it "returns a boolean" do
    assert.true!([TrueClass, FalseClass].include?(percent_chance?(50).class))
  end
end

test :collide do |args, assert|
  it "calls the block for every intersection of the two collections" do
    counter = 0
    enemies = [{ x: 0, y: 0, w: 8, h: 8, type: :e}, { x: 8, y: 0, w: 8, h: 8, type: :e}]
    # 2 enemies intersect with only 1 of these tiles
    tiles = [{ x: 0, y: 0, w: 32, h: 32}, { x: 32, y: 0, w: 32, h: 32}]

    collide(enemies, tiles) do |enemy, tile|
      counter += 1
      assert.equal!(enemy.type, :e)
    end

    assert.equal!(counter, 2)
  end

  it "has access to args in the block" do
    args.state.detect = false
    enemies = [{ x: 0, y: 0, w: 8, h: 8}]
    tiles = [{ x: 0, y: 0, w: 32, h: 32}]

    collide(enemies, tiles) do |enemy, tile|
      args.state.detect = true
    end

    assert.true!(args.state.detect)
  end

  it "wraps non-arrays in an array" do
    counter = 0
    tiles = [{ x: 0, y: 0, w: 32, h: 32}, { x: 32, y: 0, w: 32, h: 32}]
    # player only intersects with 1 tile
    player = { x: 0, y: 0, w: 8, h: 8, type: :player}

    collide(tiles, player) do |tile, player|
      counter += 1
      assert.equal!(player.type, :player)
    end

    assert.equal!(counter, 1)
  end
end

run_tests
