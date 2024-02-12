class ImportSheet < ApplicationRecord
  has_one_attached :file

  scope :by_sheet_type, -> (sheet_type) {
    where(sheet_type: sheet_type)
  }

  scope :by_status, -> (status) {
    where(status: status)
  }

  scope :since, -> (start_date) {
    where("created_at >= :start_date OR updated_at >= :start_date",
      start_date: start_date.to_time)
  }

  scope :until, -> (end_date) {
    where("created_at <= :end_date OR updated_at <= :end_date",
      end_date: end_date.to_time.end_of_day)
  }

  enum sheet_type: {
    movie: 1,
    review: 2,
  }

  enum status: {
    processing: 0,
    processed: 1,
    failed: 2,
  }
end
