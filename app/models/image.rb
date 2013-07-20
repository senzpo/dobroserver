class Image < ActiveRecord::Base
  validates :image, :blog_record_id, presence: true

  belongs_to :blog_record

  mount_uploader :image, ImageUploader

  def preview?
    File.exist?(image.preview.path)
  end

  def preview
    image.preview.url
  end

  def filename
    image.file.filename
  end

  def size
    image.file.size
  end
end
