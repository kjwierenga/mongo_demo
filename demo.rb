#!/usr/bin/env ruby

# Personal playground for mongo and mongo_mapper.
# See example use for log analysis: http://github.com/saltycrane/live-log-analyzer

# Also see:
# http://railstips.org/blog/archives/2009/06/03/what-if-a-key-value-store-mated-with-a-relational-database-system/
# http://railstips.org/blog/archives/2009/06/27/mongomapper-the-rad-mongo-wrapper/

require 'rubygems'
require 'mongo'
require 'mongo_mapper'

MongoMapper.connection = Mongo::Connection.new('localhost')
MongoMapper.database = 'log_analysis'

class Device
  include MongoMapper::Document
  # set_database_name 'device'
  
  connection Mongo::Connection.new('localhost')
end

class Lukas < Device
  key :serial,  String, :required => true
  key :version, String
  key :agent,   String
end

100.times do
  lukas = Lukas.new({
    :serial  => '5b000',
    :version => '03.08'
  })
  lukas.save
end

Lukas.all(:serial => '5b000').each do |l|
  puts l.serial
end

puts Lukas.count
Lukas.destroy_all