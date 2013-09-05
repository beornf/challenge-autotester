# Coding Challenge Autotester

Challenge autotester is a set of modules to help write and solve challenges for a programming contest / new language / interview practice. In this alpha release, Python and Ruby solutions are supported for automated unit tests (Scala in next version). Additional languages can be requested to suit your needs, otherwise definitions can be added to [compile.rb][1] and [challenge][2].

## Install

Display autocomplete in Unix shell:
```
$ ./setup
Restart shell to enable autocomplete!
```
Pressing tab will now list available arguments.

### Required Packages
Install Pip and Ruby in CentOS / Fedora:
```
$ yum -y install python-pip
$ yum -y install ruby
```
Install Pip and Ruby in Debian / Ubuntu:
```
$ sudo apt-get install python-pip
$ sudo apt-get install ruby1.9.1
```

## Ruby Example

The simple [fizz buzz][0] challenge can be written in abstract form:
```
Example: Standard fizz buzz game
Input  : 3 5 13
Output : 1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13

Example: Divisors six and four up to twelve
Input  : 6 4 12
Output : 1 2 3 Buzz 5 Fizz 7 Buzz 9 10 11 FizzBuzz
```

After coding your solution in Ruby you can test it with:
```
$ ./challenge ruby fizz_buzz
```

You will receive test feedback similar to the following:
```java
================================================================
Fizz Buzz
     0001 Standard fizz buzz game               0:00:00.001 PASS
     0002 Divisors six and four up to twelve    0:00:00.001 PASS
================================================================
  pass: 2,   fail: 0,   error: 0,   skip: 0
  total: 2 tests with 2 assertions
================================================================
```

Continue to tweak or refactor your code until all tests pass.

## Structure

Layout of directories and helper scripts:

* __abstract/__: add problem statements here
* __install/__: includes unit testing script
* __[?]-src/__: code solutions by language
* __challenge__: autotester shell script
* __setup__: enables bash completion

## Final Tip

To test all Python solutions written in [python-src][3] simply call:
```
$ ./challenge python all
```

## Bugs/Issues

Please report these [on github][4].

[0]: http://en.wikipedia.org/wiki/Fizz_buzz
[1]: install/compile.rb
[2]: challenge
[3]: python-src/
[4]: http://github.com/beornf/challenge-autotester/issues