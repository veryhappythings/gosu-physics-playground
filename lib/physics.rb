require 'rubygems'
require 'gosu'
require 'chipmunk'
require 'require_all'

ROOT = File.dirname(File.expand_path(__FILE__))

# Some things must be required first
require "#{ROOT}/physics/lib/inheritable_attributes"

require_all "#{ROOT}/physics"
