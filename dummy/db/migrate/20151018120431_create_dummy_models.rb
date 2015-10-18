class CreateDummyModels < ActiveRecord::Migration
  def change
    create_table :dummy_models do |t|
      t.integer :time_interval_value, default:0, null: true
      t.integer :time_interval_type, default:0, null: false

      t.timestamps null: false
    end
  end
end
