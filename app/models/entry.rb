## The main model: Entry
#
# Contains information about a file that user has uploaded. Description is optional, everything else is required.
#
# The actual data (xml file user want's to upload) is not stored in the model, but on disk. Filename for this is found
# in field filename_system.
class Entry < ActiveRecord::Base
  # Just basic validations, nothing fancy
  validates :name, length: { minimum: 2 }
  validates :filename_user, :filename_system, :filesize, :upload_ip, presence: true

  # Get most recent entries, for a quick view at the front page
  scope :recent, -> { order('created_at DESC').limit(5) }

  # Always return the most recent one first
  default_scope -> { order('created_at DESC') }

  ##
  # Retrieve the xml file on disk for this entry
  def fetch_data
    data = ''
    File.open(Rails.root.join('public', 'uploaded_files', self.filename_system), 'r') do |file|
      data = file.read
      file.close
    end
    return data.encode!('UTF-8', 'UTF-8', :invalid => :replace).to_s
  end

  ##
  # Go trough the XML data and check if a node/element with a given name exists in the data
  #
  # You could alse search matching nodes directly with xpath, the original idea here was to make a list
  # of all element names so you don't have to search trough the whole XML file every time. This idea was dropped
  # because percormance is not a real issue here. Also this approach allows me to use casecmp.
  #
  # Return true if there is a match, otherwise return false.
  def element_exists?(nodename)
    nodes = []
    xmldata = Nokogiri::XML(self.fetch_data, 'UTF-8') { |c| c.noblanks }
    xmldata.xpath('//*').each do |node|
      nodes << node.name.to_s
    end

    nodes.each do |n|
      if n.to_s.casecmp(nodename) == 0
        return true
      end
    end
    return false
  end
end
