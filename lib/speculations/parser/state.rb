# frozen_string_literal: true

module Speculations::Parser::State extend self
  require_relative './state/candidate'
  require_relative './state/in'
  require_relative './state/includes'
  require_relative './state/out'
  require_relative './state/triggers'

  extend Triggers
end
