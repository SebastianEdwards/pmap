#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path( File.dirname(__FILE__) + '/../lib' )

require 'test/unit'
require 'rubygems'
require 'pmap'

class Pmap_Test < Test::Unit::TestCase

  def bad_test_noproc_range
    range = (1..10)
    assert_equal(range.map, range.pmap)
  end

  def test_basic_range
    proc = Proc.new {|x| x*x}
    range = (1..10)
    assert_equal(range.map(&proc), range.pmap(&proc))
  end

  def bad_test_noproc_array
    array = (1..10).to_a
    assert_equal(array.map, array.pmap)
  end

  def test_basic_array
    proc = Proc.new {|x| x*x*x}
    array = (1..10).to_a
    assert_equal(array.map(&proc), array.pmap(&proc))
  end

  def test_time_savings
    start = Time.now
    (1..10).peach{ sleep 1 }
    elapsed = Time.now-start
    assert(elapsed < 2, 'Parallel sleeps too slow: %.1f seconds' % elapsed)
  end
end
