def run_tests
  $gtk.tests&.passed.clear
  $gtk.tests&.inconclusive.clear
  $gtk.tests&.failed.clear
  puts "💨 running tests"
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

class GTK::Assert
  # define custom assertions here!
  # def rect!(obj)
  #   true!(obj.x && obj.y && obj.w && obj.h, "doesn't have needed properties")
  # end

  # takes three params: lambda that gets called, the error class, and the
  # expected message.
  # usage: assert.exception!(KeyError, "Key not found: :not_present") { text(args, :not_present) }
  def exception!(error_class, message=nil)
    begin
      yield
    rescue StandardError => e
      equal!(e.class, error_class)

      if message
        equal!(e.message, message)
      end
    end
  end

  # usage: assert.includes!([1, 2, 3], 3)
  def includes!(arr, val)
    true!(arr.include?(val), "array: #{arr} does not include the val: #{val}")
  end

  # usage: assert.not_includes!([1, 2, 3], 4)
  def not_includes!(arr, val)
    false!(arr.include?(val), "array: #{arr} does include the val: #{val}")
  end

  # usage: assert.int!(2 + 3)
  def int!(obj)
    true!(obj.is_a?(Integer), "that's no integer!")
  end
end

def test(method)
  test_name = "test_#{method}"

  define_method(test_name) do |args, assert|
    yield(args, assert)
  end
end

test :assert_includes do |args, assert|
  it "works!" do
    assert.includes!([1, 2, 3], 3)
  end
end

test :assert_not_includes do |args, assert|
  it "works!" do
    assert.not_includes!([1, 2, 3], 4)
  end
end

test :assert_int do |args, assert|
  it "works!" do
    assert.int!(2 + 3)
  end
end

test :assert_exception do |args, assert|
  class MyError < StandardError; end
  assert.exception!(MyError, "oh no") { raise MyError.new("oh no") }
end
