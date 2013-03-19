class String
  def constantize
    self.split("::").inject(Module) {|acc, val| acc.const_get(val)}
  end
end

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

module BusinessRules
  class SomeTax < Command
    def initialize
    end

    def execute
      @@result *= 0.1
    end
  end

  class ISSTax < Command
    def initialize
    end

    def execute
      @@result += 50
    end
  end
end

cmd = CompositeCommand.new 10
BusinessRules.constants.each {|constant| cmd.add_commmand "BusinessRules::#{constant}".constantize.send(:new) }
cmd.execute
p cmd.result # ~> 10*0.1+50=51
