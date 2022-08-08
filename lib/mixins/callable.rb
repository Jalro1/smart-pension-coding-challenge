# frozen_string_literal: true

module Callable
  def call(...)
    new(...).send(:call)
  end
end
