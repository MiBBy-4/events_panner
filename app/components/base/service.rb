# frozen_string_literal: true

module Base
  class Service
    attr_reader :value, :error

    def initialize(*_args); end

    def call
      raise NotImplementedError
    end

    alias call! call

    def success?
      !error?
    end

    def error?
      error.present?
    end

    def success(value)
      self.value = value
    end

    alias success! success

    def fail!(error)
      self.error = error
    end

    def self.call(*args)
      instance = new(*args)

      instance.call

      instance
    end

    def self.call!(*args)
      instance = new(*args)

      instance.call

      instance
    end

    private

    attr_writer :value, :error
  end
end
