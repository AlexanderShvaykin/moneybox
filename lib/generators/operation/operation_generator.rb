# frozen_string_literal: true

class OperationGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def create_operation_file
    template "operation.rb.tt", File.join("app", "operations", class_path, "#{file_name}_operation.rb")
    template "operation_spec.rb.tt", File.join("spec", "operations", class_path, "#{file_name}_operation_spec.rb")
  end
end
