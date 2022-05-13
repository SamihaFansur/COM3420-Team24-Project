# controller for ActiveStorage to upload files to the database
class AttachmentsController < ApplicationController
  # custom behaviour for removing an attachment to an ECF - remains and reloads the same page.
  def purge
    attachment = ActiveStorage::Attachment.find(params[:id])
    attachment.purge
    redirect_back fallback_location: root_path, notice: 'Successfully deleted attachment'
  end
end
