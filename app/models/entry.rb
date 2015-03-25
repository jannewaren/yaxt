## The main model: Entry
#
# Contains information about a file that user has uploaded. Description is optional, everything else is required.
#
# The actual data (xml file user want's to upload) is not stored in the model, but on disk. Filename for this is found
# in field filename_system.
class Entry < ActiveRecord::Base
  validates :name, length: { minimum: 2 }
  validates :filename_user, :filename_system, :filesize, :upload_ip, presence: true

  # Get most recent entries, for a quick view at the front page
  scope :recent, -> { order('created_at DESC').limit(5) }
end
