require 'csv'

class ImportMoviesJob < ApplicationJob
  queue_as :default

  def perform(import_sheet_id)
    import_sheet = ImportSheet.find(import_sheet_id)
    return unless import_sheet.present?

    batch_offset = batch_number = 0
    batch_size = 1000

    loop do
      start_limit = batch_number * batch_size + batch_offset
      end_limit = start_limit + batch_size - 1
      batch_number += 1

      records = CSV.parse(import_sheet.file.download, headers: true)[start_limit..end_limit]
      break if records.blank?

      inserted_hash = records.map(&:to_h).each_with_object([]) do |record, memo|
        memo << {
          name: record["Movie"],
          description: record["Description"],
          year: record["Year"],
          actor: record["Actor"],
          director: record["Director"],
          filming_location: record["Filming location"],
          country: record["Country"],
        }
      end

      Movie.insert_all(inserted_hash)
    end
  end
end