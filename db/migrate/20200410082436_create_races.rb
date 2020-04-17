class CreateRaces < ActiveRecord::Migration[6.0]
  def change
    create_table :races do |t|
      t.string :name
      t.string :member_one
      t.string :member_two

      t.timestamps
    end

    create_table :races_racers, id: false do |t|
      t.belongs_to :races
      t.belongs_to :racers
    end
  end
end
