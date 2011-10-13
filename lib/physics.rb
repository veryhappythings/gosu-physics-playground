require 'rubygems'
require 'gosu'
require 'chipmunk'

ROOT = File.dirname(File.expand_path(__FILE__))

require "#{ROOT}/physics/lib/require_all"

require_all "#{ROOT}/physics"
