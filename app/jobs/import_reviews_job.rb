require 'csv'

class ImportReviewsJob < ApplicationJob
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

      movies_hash = fetch_movies_hash(records)
      inserted_hash = records.map(&:to_h).each_with_object([]) do |record, memo|
        memo << {
          movie_id: movies_hash[record["Movie"]],
          user: record["User"],
          stars: record["Stars"],
          body: record["Review"],
        }
      end

      Review.insert_all(inserted_hash)
    end
  end

  def fetch_movies_hash(records)
    Movie.where(name: records.pluck("Movie")).each_with_object({}) do |movie, memo|
      memo[movie.name] = movie.id
    end
  end
end