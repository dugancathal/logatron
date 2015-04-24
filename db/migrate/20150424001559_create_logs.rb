class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.text :body
      t.timestamp :timestamp
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
