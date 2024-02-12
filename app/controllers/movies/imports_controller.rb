class Movies::ImportsController < ApplicationController
  def create
    imported_sheet = ImportSheet.new(file: import_params[:file], sheet_type: :movie)

    if imported_sheet.save
      ImportMoviesJob.perform_later(imported_sheet.id)
      render(json: { message: "Sheet is processing" })
    else
      render(json: imported_sheet.errors, status: :unprocessable_entity)
    end
  end

  def import_params
    params.require(:movie).permit(:file)
  end
end