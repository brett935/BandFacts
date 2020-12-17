class CreateSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches do |t|
      t.string :searched_name
      t.boolean :success
      t.json :response

      t.timestamps
    end
  end
end
