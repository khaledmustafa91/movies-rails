class Reviews::ImportsController < ApplicationController
  def create
    imported_sheet = ImportSheet.new(file: import_params[:file], sheet_type: :review)

    if imported_sheet.save
      ImportReviewsJob.perform_later(imported_sheet.id)
      render(json: { message: "Sheet is processing" })
    else
      render(json: imported_sheet.errors, status: :unprocessable_entity)
    end
  end

  def import_params
    params.require(:review).permit(:file)
  end
end