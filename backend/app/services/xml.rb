# frozen_string_literal: true

module Meshup
  module XML
    def self.convert(hash, tag)
      return nil if hash.nil? || tag.nil?

      wrapper = { tag.to_s => hash}
      begin
        xml = Gyoku.xml(wrapper)
      rescue StandardError => e
        nil
      end
    end
  end
end
