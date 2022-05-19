# Controller for Meeting Notes 
class MeetingNotesController < ApplicationController
  # Creating a meeting note from show meeting page.
  def create
    @meeting_note = MeetingNote.new(meeting_note_params)
    if @meeting_note.save
      flash[:success] = 'Meeting note added.'
      redirect_back(fallback_location: meetings_path)
    else
      redirect_back(fallback_location: meetings_path)
    end
  end

  def destroy
    @meeting_note = MeetingNote.find(params[:id])
    @meeting_note.destroy
    flash[:notice] = 'Note was successfully deleted.'
    redirect_back(fallback_location: meetings_path)
  end

  def meeting_note_params
    params
      .require(:meeting_note)
      .permit(
        :name, :description, :meeting_id
      )
  end
end