# frozen_string_literal: true

class FindOperation < ApplicationOperation
  def call(repo)
    entry = repo.find_by(id: params[:id])

    if entry
      Success([:ok, entry])
    else
      Failure([:not_found, Array(title: I18n.t("errors.not_found"))])
    end
  end
end
