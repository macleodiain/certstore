class Cert < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :name, presence: true
  validates :image, presence: true

  scope :sorted, -> { order(Arel.sql("expires ASC NULLS LAST")) }

  def expired?
    expires < Time.current
  end

  def expires_in
    difference = expires - Date.current
    if expired?
      "EXPIRED"
    else
      if difference > 365
        "#{(difference / 365.25).round(1)} Years Remaining"
      else
        "#{difference.to_i} Days Remaining"
      end
    end
  end

  def attached_file_type
    file_type = image.content_type
    if file_type.include? "image"
      "image"
    elsif file_type.include? "pdf"
      "pdf"
    else
      "unknown"
    end
  end
end

# do |attachable|
#     attachable.variant :thumb, resize_to_limit: [ 300, 300 ]
#   end
