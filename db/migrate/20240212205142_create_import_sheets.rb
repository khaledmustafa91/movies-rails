class CreateImportSheets < ActiveRecord::Migration[7.0]
  def change
    create_table :import_sheets do |t|
      t.integer(:sheet_type)
      t.integer(:status, default: 0)
      t.text(:error_message)

      t.timestamps
    end
  end
end
