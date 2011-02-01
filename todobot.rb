#!/usr/bin/env ruby
require 'rubygems'
require 'jabber/bot'

@jabber_id = 'you@yourdomain.com/dir'#Using a location because I had problems connecting with dreamhost
@password = 'password'
@todoscript = '/Users/home/todo.sh -p -v -f' #Make sure you have -f otherwise deletions fail
@masters = ['address@host.com', 'another@wherever.com'] #Add any emails that you want to be able to access this

# Create a public Jabber::Bot
bot = Jabber::Bot.new(
  :jabber_id => @jabber_id, 
  :password  => @password, 
  :master    => @masters,
  :is_public => false
)

bot.add_command(
  :syntax       => 'todo <string>',
  :description  => 'View Todos',
  :regex        => /^todo\s+.+$/,
  :alias        => [
      :syntax => 't <string>',
      :regex  => /^t\s+.+$/
  ]
) do |sender, command|
  %x[#{@todoscript} #{command}]
end

# Bring your new bot to life
bot.connect
