#!/usr/bin/env ruby

class Spec
  def initialize(list)
    @ruby = {header: "#!/usr/bin/env ruby\n\nTurn.config do |c|\n  " +
            "c.matchcase = nil\n  c.natural = true\n  c.format = :outline\nend\n",
            depend: "load '?'", open: "\n\ndescribe '?' do", close: "end",
            unit: "\n  it '?' do\n    ?('?').must_equal '?'\n  end\n", ext: "rb"}
    @python = {header: "#!/usr/bin/env python\n\nimport imp",
              depend: "? = imp.load_source('src', './?').?",
              unit: "\n    def test?(self):\n        assert ?('?') == '?'",
              open: "\n\nclass ?:", close: "", ext: "py"}
    self.open_files(list)
  end

  def open_files(list)
    @prog = []
    instance_variables.reject {|p| p == :@prog}.each do |var|
      dir = './' + var.to_s[1..-1] + '-src/'
      hash = instance_variable_get(var)
      hash.merge!({files: [], var: var.to_s[1..-1]})
      list.each do |dep|
        if File.exists? dir + dep
          hash[:files] << dep
        end
      end
      @prog << [File.open(dir + 'spec.' + hash[:ext], 'w'), hash]
    end
  end

  def header
    @prog.each do |file, hash|
      file.write(hash[:header])
      hash[:files].each {|dep| file.write("\n" + hash[:depend].gsub('?', dep))}
    end
  end

  def close
    @prog.each {|file, hash| file.close}
  end

  def add(fname, set)
    @prog.each do |file, hash|
      if hash[:files].include? fname
        pack = hash[:var] == 'ruby' ? ' ' : ''
        file.write(hash[:open].sub('?', fname.sub('_', ' ').gsub(/\w+/) {
                  |word| word.capitalize}.sub(' ', pack)))
        example = set.collect {|desc| desc['Example']}
        if hash[:var] == 'python'
          example.collect! {|desc| desc.split.collect {|word| word.capitalize}}
          begin
            dup = Hash.new
            example.each do |desc|
              if not dup.include? desc[0]
                dup[desc[0]] = 0
              end
              dup[desc[0]] += 1
            end
            dup.reject! {|key, val| val == 1}
            example.each {|desc| if dup.keys.include? desc[0]; desc.shift end }
          end while dup.size > 0
          example.collect! {|desc| desc[0]}
        end
        set.each_with_index do |desc, pos|
          if desc.size == 3
            replace = [example[pos], fname, desc['Input'], desc['Output']]
            unit = hash[:unit]
            while replace.length > 0
              unit = unit.sub('?', replace.shift.chomp(' '))
            end
            file.write(unit)
          end
        end
        file.write(hash[:close])
      end
    end
  end
end

require 'digest/md5'
val, cache = nil, './install/cache'
if File.exists? cache
  File.open(cache, 'r') {|f| val = f.read}
end
hex = Digest::MD5.hexdigest(`ls -lc ./abstract`)

if hex != val
  list = `ls ./abstract`.split
  spec = Spec.new(list)
  spec.header
  list.each do |fname|
    set, group = [], ['Example', 'Input', 'Output']
    File.open('./abstract/' + fname).each_line do |line|
      group.each_with_index do |word, id|
        if line =~ /#{word}\s*: (.*)/
          if id == 0
            set << Hash.new
          end
          set[-1][word] = $1
        end
      end
    end
    spec.add(fname, set)
  end
  spec.close
  File.open(cache, 'w') {|f| f.write(hex)}
end