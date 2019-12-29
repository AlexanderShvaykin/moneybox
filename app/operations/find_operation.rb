class FindOperation < ApplicationOperation
  def call(repo)
    entry = repo.find_by(id: params[:id])

    if entry
      Success([:ok, entry])
    else
      Failure([:not_found, Hash[message: "Record not_found"]])
    end
  end
end
