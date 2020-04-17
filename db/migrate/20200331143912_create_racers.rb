class CreateRacers < ActiveRecord::Migration[6.0]
  def change
    create_table :racers do |t|
      t.string :name
      t.integer :number

      t.timestamps
    end
  end
end