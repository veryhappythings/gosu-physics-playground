require 'rubygems'
require 'gosu'
require 'chipmunk'

ROOT = File.dirname(File.expand_path(__FILE__))

# Some things must be required first
require "#{ROOT}/physics/lib/require_all"
require "#{ROOT}/physics/lib/inheritable_attributes"

require_all "#{ROOT}/physics"
