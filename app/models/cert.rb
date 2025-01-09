class Cert < ApplicationRecord
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
        "#{(difference / 365.25).round(1)} years remaining"
      else
        "#{difference.to_i} days remaining"
      end
    end
  end
end

# do |attachable|
#     attachable.variant :thumb, resize_to_limit: [ 300, 300 ]
#   end
