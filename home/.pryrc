# Using these pry gems -- copy to your Gemfile
# group :development, :test do
#   gem 'awesome_print' # pretty print ruby objects
#   gem 'pry' # Console with powerful introspection capabilities
#   # pick either:
#      # using byebug, but has issues with Zeitwerk
#      gem 'pry-byebug' # Integrates pry with byebug
#
#      # using default ruby debuggger
#      gem 'pry-stack_explorer'
#      gem 'pry-nav'
#
#
#   gem 'pry-doc' # Provide MRI Core documentation
#   gem 'pry-rails' # Causes rails console to open pry. `DISABLE_PRY_RAILS=1 rails c` can still open with IRB
#   gem 'pry-rescue' # Start a pry session whenever something goes wrong.
#   gem 'pry-theme' # An easy way to customize Pry colors via theme files
# end

# === EDITOR ===
# Use Vi
# Pry.editor = 'vi'
# Or RubyMine or other
Pry.config.editor = proc { |file, line| "rubymine --line #{line} #{file}" }

# === HISTORY ===
# Run last command with return
Pry::Commands.command /^$/, "repeat last command" do
  _pry_.run_command Pry.history.to_a.last
end

unless defined?(Pry::Prompt)
  Pry.config.prompt =  Pry::NAV_PROMPT
end

# === COLORS ===
if defined?(PryTheme)
  Pry.color = true
  Pry.config.theme = "railscasts"
  Pry.config.prompt = PryRails::RAILS_PROMPT if defined?(PryRails::RAILS_PROMPT)
  Pry.config.prompt ||= Pry.prompt
end

# Shortcut for calling pry_debug
def pry_debug
  if defined?(PryByebug)
    puts 'Using PryByebug setup'
    Pry.commands.alias_command 'bt', 'backtrace'
    Pry.commands.alias_command 's', 'step'
    Pry.commands.alias_command 'n', 'next'
    Pry.commands.alias_command 'c', 'continue'
    Pry.commands.alias_command 'fin', 'finish'
    Pry.commands.alias_command 'f', 'frame'
    Pry.commands.alias_command 'b', 'break'
    display_shortcuts
  else
    if defined?(PryNav)
      puts 'Using PryNav debugging setup'
      Pry.commands.alias_command 's', 'step'
      Pry.commands.alias_command 'n', 'next'
      Pry.commands.alias_command 'c', 'continue'
    end

    if defined?(PryStackExplorer)
      puts 'Using PryStackExplorer debugging setup.'
      Pry.commands.alias_command 'f', 'frame'
      # Pry.commands.alias_command 'bt', 'stack' # broken with pry-stack_explorer
    end
  end

  puts "Run command 'more_help'"
end

# Use `l` for whereami as that's what rdbg uses
Pry.commands.alias_command 'l', 'whereami'

Pry.config.commands.alias_command 'h', 'hist -T 20', desc: 'Last 20 commands'
Pry.config.commands.alias_command 'hg', 'hist -T 20 -G', desc: 'Up to 20 commands matching expression'
Pry.config.commands.alias_command 'hG', 'hist -G', desc: 'Commands matching expression ever used'
Pry.config.commands.alias_command 'hr', 'hist -r', desc: 'hist -r <command number> to run a command'

# Fix deprecation warning, so override default for now.
# Remember to eventually remove this!
# WARNING: the show-doc command is deprecated. It will be removed from future Pry versions.
# Please use 'show-source' with the -d (or --doc) switch instead
Pry.commands.alias_command '?', 'show-source -d'

# Use awesome_print (or amazing_print)
begin
  require 'awesome_print'
  AwesomePrint.pry!
rescue LoadError => err
  begin
    puts "no awesome_print :( #{err}"
    puts 'trying amazing_print'
    require 'amazing_print'
    AmazingPrint.pry!
  rescue LoadError => err2
    puts "no awesome_print :( #{err2}"
  end
end

# Hit Enter to repeat last command
Pry::Commands.command(/^$/, 'repeat last command') do
  pry_instance.run_command Pry.history.to_a.last
end

before_session_hook = Pry::Hooks.new.add_hook(:before_session, :add_dirs_to_load_path) do
  # adds the directories /spec and /test directories to the path if they exist and not already included
  current_dir = `pwd`.chomp
  dirs_added = %w[spec test presenters lib]
               .map { |d| "#{current_dir}/#{d}" }
               .map do |path|
    if File.exist?(path) && !$:.include?(path)
      i $: << path
      path
    end
  end.compact
  puts "Added #{dirs_added.join(', ')} to load path per hook in ~/.pryrc." unless dirs_added.empty?
end
before_session_hook.exec_hook(:before_session)

def more_help
  puts 'Use binding.b to open up rdbg, then run `pry` to get into pry with that context'
  puts
  puts 'Helpful shortcuts:'
  puts 'hh  : hist -T 20       Last 20 commands'
  puts 'hg : hist -T 20 -G    Up to 20 commands matching expression'
  puts 'hG : hist -G          Commands matching expression ever used'
  puts 'hr : hist -r          hist -r <command number> to run a command'
  puts

  puts 'Samples variables'
  puts 'a_array  :  [1, 2, 3, 4, 5, 6]'
  puts 'a_hash   :  { hello: "world", free: "of charge" }'
  puts 'do_time(repitions = 100, &block)'
  puts
  puts 'helper   : Access Rails helpers'
  puts 'app      : Access url_helpers'
  puts
  puts 'require "rails_helper"              : To include Factory Girl Syntax'
  puts 'include FactoryGirl::Syntax::Methods  : To include Factory Girl Syntax'
  puts
  puts 'or if you defined one...'
  puts 'require "pry_helper"'
  puts
  puts 'Sidekiq::Queue.new.clear              : To clear sidekiq'
  puts 'Sidekiq.redis { |r| puts r.flushall } : Another clear of sidekiq'
  puts
  puts "Run `require 'factory_bot'; FactoryBot.find_definitions` for FactoryBot"
  puts
  puts '=' * 80
  puts 'Debugging Shortcuts'
  puts
  display_shortcuts
end

def display_shortcuts
  puts 'Installed debugging Shortcuts (matches rdbg where possible)'
  puts 'l  :  whereami'
  puts 's  :  step'
  puts 'n  :  next'
  puts 'c  :  continue'
  puts
  puts 'Stack movement'
  if defined? PryByebug
    puts 'bt    :  backtrace'
    puts 'fin   :  finish'
  else
    puts 'backtrace (bt) and finish (fin) are not available in Pry'
    puts 'Use `binding.b` to start Ruby debug'
  end

  puts 'f     :  frame'
  puts 'up    :  up'
  puts 'down  :  down'
  puts
  puts 'Introspection'
  puts '$    :  show whole method of current context'
  puts '$ foo:  show definition of foo'
  puts '? foo:  show docs for for'
  puts
  puts "Be careful not to use shortcuts for temp vars, like 'u = User.first`"
  puts 'Run `help` to see all the pry commands that would conflict (and lots good info)'
  puts 'Run `more_help to see many helpful tips from the ~/.pryrc`'
  puts
  if defined?(PryByebug)
    puts 'b  :  break (only for byebug)'
    puts 'fin  :  finish (only for byebug)'
    puts
  end
  ''
end

# Utility global methods for convenience
def a_array
  (1..6).to_a
end

def a_hash
  { hello: 'world', free: 'of charge' }
end

def do_time(repetitions = 100, &block)
  require 'benchmark'
  Benchmark.bm { |b| b.report { repetitions.times(&block) } }
end

def each_without_puma_config(enumerable)
  enumerable.filter { |key, _value| key != 'puma.config' }
end

# https://github.com/pry/pry/issues/2185#issuecomment-945082143
ENV['PAGER'] = ' less --raw-control-chars -F -X'

# by default, set up the debug shortcuts
pry_debug
puts "Loaded ~/.pryrc. Run 'more_help' or 'display_shortcuts' for more tips"
