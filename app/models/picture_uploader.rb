class PictureUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => ['post_picture']
  cloudinary_transformation :quality => 80

  version :standard do
    process :resize_to_fit => [300, 300]
    process :convert => 'jpg'
    cloudinary_transformation :quality => 70
  end
end
