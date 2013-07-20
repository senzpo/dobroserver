class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :attachment
      t.integer :blog_record_id
    end
  end
end
