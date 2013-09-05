#!/usr/bin/env ruby

Turn.config do |c|
  c.matchcase = nil
  c.natural = true
  c.format = :outline
end

load 'elvish_numbers'
load 'fizz_buzz'

describe 'Elvish Numbers' do
  it 'Given 527 in Roman numerals' do
    elvish_numbers('DXXVII').must_equal 'lemintuksa yukainen otso'
  end

  it 'Given 2648 in Roman numerals' do
    elvish_numbers('MMDCXLVIII').must_equal 'yuhumi enektuksa kankainen tolto'
  end

  it 'Given 3917 in Roman numerals' do
    elvish_numbers('MMMCMXVII').must_equal 'nelhumi huetuksa okkea'
  end
end

describe 'Fizz Buzz' do
  it 'Standard fizz buzz game' do
    fizz_buzz('3 5 13').must_equal '1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13'
  end

  it 'Divisors six and four up to twelve' do
    fizz_buzz('6 4 12').must_equal '1 2 3 Buzz 5 Fizz 7 Buzz 9 10 11 FizzBuzz'
  end

  it 'Alternating fizz and buzz' do
    fizz_buzz('1 2 7').must_equal 'Fizz FizzBuzz Fizz FizzBuzz Fizz FizzBuzz Fizz'
  end
end