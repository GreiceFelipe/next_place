class CreateRatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :rate_places do |t|
      t.references :user, null: false, foreign_key: true
      t.references :place, null: false, foreign_key: true
      t.string :comment
      t.float :rate, null: false

      t.timestamps
    end
  end
end
