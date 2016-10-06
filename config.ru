# Load assets
require "sass/plugin/rack"

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

require './ipsum'

run Ipsum.new
