class CreateParameters < ActiveRecord::Migration
  def self.up
    create_table :parameters do |t|
      t.integer :code
      t.string :formulation
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :parameters
  end
end
