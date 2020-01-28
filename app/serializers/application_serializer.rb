# frozen_string_literal: true

class ApplicationSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  delegate :url_helpers, to: :class

  def self.url_helpers
    Rails.application.routes.url_helpers
  end
end
