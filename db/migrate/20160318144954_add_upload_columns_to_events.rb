class AddUploadColumnsToEvents < ActiveRecord::Migration
  def change
  	add_attachment :events, :image
  end
end
