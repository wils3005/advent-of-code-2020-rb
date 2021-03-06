# frozen_string_literal: true

require 'sorbet-runtime'

def reload
  Dir.glob(File.join("#{__dir__}/lib/*.rb")).sort.each(&method(:load))
end

Pry.config.commands.command 'reload', 'reloads all your crappy code' do
  reload
end

Pry.config.commands.command 'rubocop', 'runs sorbet on everything' do
  system 'rubocop -a'
end

Pry.config.commands.command 'srb', 'runs sorbet on everything' do
  `bundle exec srb t`
end

reload
