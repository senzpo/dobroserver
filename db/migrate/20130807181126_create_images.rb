class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image
      t.integer :blog_record_id
    end
    add_index :images, :blog_record_id
  end
end
