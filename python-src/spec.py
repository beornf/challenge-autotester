#!/usr/bin/env python

import imp
fizz_buzz = imp.load_source('src', './fizz_buzz').fizz_buzz
self_describe = imp.load_source('src', './self_describe').self_describe

class FizzBuzz:
    def testStandard(self):
        assert fizz_buzz('3 5 13') == '1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13'
    def testDivisors(self):
        assert fizz_buzz('6 4 12') == '1 2 3 Buzz 5 Fizz 7 Buzz 9 10 11 FizzBuzz'
    def testAlternating(self):
        assert fizz_buzz('1 2 7') == 'Fizz FizzBuzz Fizz FizzBuzz Fizz FizzBuzz Fizz'

class SelfDescribe:
    def testZero(self):
        assert self_describe('1210') == '1210'
    def testOne(self):
        assert self_describe('1000000') == '1210 2020 21200'
    def testFour(self):
        assert self_describe('4000000') == '1210 2020 21200 3211000'