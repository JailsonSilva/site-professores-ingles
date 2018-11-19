class CreateTexts < ActiveRecord::Migration[5.1]
  def change
    create_table :texts do |t|
      t.string :title
      t.string :author
      t.text :content

      t.timestamps
    end
  end
end
