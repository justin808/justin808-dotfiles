# See https://github.com/burke/zeus/issues/466#issuecomment-60242431
if defined?(::Rails) && Rails.env
  if Rails::VERSION::MAJOR == 3
    verbose, $VERBOSE = $VERBOSE, nil
    if defined?(Rails::Console)
      Rails::Console::IRB = ::Pry unless Rails::Console::IRB == ::Pry
    end
    $VERBOSE = verbose

    unless defined? ::Pry::ExtendCommandBundle
      ::Pry::ExtendCommandBundle = Module.new
    end
  end

  if defined?(Rails) && Rails::VERSION::MAJOR == 4
    unless Rails.application.config.console == ::Pry
      Rails.application.config.console = ::Pry
    end
  end

  if ((Rails::VERSION::MAJOR == 3 && Rails::VERSION::MINOR >= 2) ||
      Rails::VERSION::MAJOR == 4)
    unless defined? ::Rails::ConsoleMethods
      require 'rails/console/app'
      require 'rails/console/helpers'

      TOPLEVEL_BINDING.eval('self').extend ::Rails::ConsoleMethods
    end
  end
end

Pry::Commands.block_command "noconflict", "Rename step to sstep and next to nnext" do
  Pry::Commands.rename_command("nnext", "next")
  Pry::Commands.rename_command("bbreak", "break")
end

Pry::Commands.block_command "unnoconflict", "Revert to normal next and break" do
  Pry::Commands.rename_command("next", "nnext")
  Pry::Commands.rename_command("break", "bbreak")
end

## Useful Collections

def a_array
  (1..6).to_a
end

def a_hash
  {hello: "world", free: "of charge"}
end

## Benchmarking
# Inspired by <http://stackoverflow.com/questions/123494/whats-your-favourite-irb-trick/123834#123834>.

def time(repetitions = 100, &block)
  require 'benchmark'
  Benchmark.bm{|b| b.report{repetitions.times(&block)}}
end


Pry.config.color = true
Pry.config.prompt = Pry::NAV_PROMPT

Pry.config.commands.alias_command "h", "hist -T 20", desc: "Last 20 commands"
Pry.config.commands.alias_command "hg", "hist -T 20 -G", desc: "Up to 20 commands matching expression"
Pry.config.commands.alias_command "hG", "hist -G", desc: "Commands matching expression ever used"
Pry.config.commands.alias_command "hr", "hist -r", desc: "hist -r <command number> to run a command"

if defined?(PryByebug)
  Pry.commands.alias_command 'sss', 'show-stack'
  Pry.commands.alias_command 'ss', 'step'
  Pry.commands.alias_command 'nn', 'next'
  Pry.commands.alias_command 'cc', 'continue'
  Pry.commands.alias_command 'fin', 'finish'
  Pry.commands.alias_command 'uu', 'up'
  Pry.commands.alias_command 'dd', 'down'
  Pry.commands.alias_command 'ff', 'frame'
  Pry.commands.alias_command 'bb', 'break'
  Pry.commands.alias_command 'ww', 'whereami'
end



begin
  require 'awesome_print'
  # Pry.config.print = proc { |output, value| output.puts value.ai }
  AwesomePrint.pry!
rescue LoadError => err
  puts "no awesome_print :("
end

my_hook = Pry::Hooks.new.add_hook(:before_session, :add_dirs_to_load_path) do
  # adds the directories /spec and /test directories to the path if they exist and not already included
  dir = `pwd`.chomp
  dirs_added = []
  %w(spec test presenters lib).map{ |d| "#{dir}/#{d}" }.each do |p|
    if File.exist?(p) && !$:.include?(p)
      $: << p
      dirs_added << p
    end
  end
  puts "Added #{ dirs_added.join(", ") } to load path in ~/.pryrc." if dirs_added.present?
end

# Hit Enter to repeat last command
# Pry::Commands.command /^$/, "repeat last command" do
#   _pry_.run_command Pry.history.to_a.last
# end

my_hook.exec_hook(:before_session)


puts "Loaded ~/.pryrc"
puts
def more_help
  puts "Helpful shortcuts:"
  puts "hh  : hist -T 20       Last 20 commands"
  puts "hg : hist -T 20 -G    Up to 20 commands matching expression"
  puts "hG : hist -G          Commands matching expression ever used"
  puts "hr : hist -r          hist -r <command number> to run a command"
  puts

  puts "Samples variables"
  puts "a_array  :  [1, 2, 3, 4, 5, 6]"
  puts "a_hash   :  { hello: \"world\", free: \"of charge\" }"
  puts
  puts "helper   : Access Rails helpers"
  puts "app      : Access url_helpers"
  puts
  puts "require \"rails_helper\"              : To include Factory Girl Syntax"
  puts "include FactoryGirl::Syntax::Methods  : To include Factory Girl Syntax"
  puts
  puts "or if you defined one..."
  puts "require \"pry_helper\""
  puts
  puts "Sidekiq::Queue.new.clear              : To clear sidekiq"
  puts "Sidekiq.redis { |r| puts r.flushall } : Another clear of sidekiq"
  puts
  puts "Debugging Shortcuts"
  puts 'sss :  show-stack'
  puts 'ss  :  step'
  puts 'nn  :  next'
  puts 'cc  :  continue'
  puts 'fin :  finish'
  puts 'uu  :  up'
  puts 'dd  :  down'
  puts 'ff  :  frame'
  puts 'bb  :  break'
  puts 'ww  :  whereami'
  ""
 end
 puts "Run 'more_help' to see tips"
