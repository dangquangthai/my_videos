# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include InitializeComponentContextConcern
end
