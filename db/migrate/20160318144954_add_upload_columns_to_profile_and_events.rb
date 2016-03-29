class AddUploadColumnsToProfileAndEvents < ActiveRecord::Migration
  def change
  	add_attachment :profiles, :document
  	add_attachment :events, :image
  end
end
