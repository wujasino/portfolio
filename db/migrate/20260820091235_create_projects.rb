class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :tagline, null: false
      t.text :description, null: false
      t.text :stack, null: false, default: "[]"
      t.string :url
      t.string :repo
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :projects, :position
  end
end
