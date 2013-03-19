class Command
  @@result = 0

  def initialize
  end

  def execute
  end

  # Accessor for class variable
  def result
    @@result
  end

  def result= value
    @@result = value
  end
end

class CompositeCommand < Command
  def initialize(result)
    @commands = []
    @@result = result
  end

  def add_commmand command
    @commands.push command
  end

  def execute
    @commands.each {|command| command.execute }
  end
end

class WickedSickBusinessRule < Command
  def initialize(multiplier)
    @multiplier = multiplier
  end

  def execute
    @@result *= @multiplier
  end
end

class NoobsBusinessRule < Command
  def initialize(sum)
    @sum = sum
  end

  def execute
    @@result += @sum
  end
end

cmd = CompositeCommand.new 1
cmd.add_commmand WickedSickBusinessRule.new 1 # 1*1=1
cmd.add_commmand NoobsBusinessRule.new 2 # 1+2=3
cmd.add_commmand WickedSickBusinessRule.new 3 # 3*3=9
cmd.add_commmand NoobsBusinessRule.new 2 # 9+2=11
cmd.execute
p cmd.result # ~> 11
