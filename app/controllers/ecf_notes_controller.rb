# frozen_string_literal: true

# controller for 'EcfNote' table
class EcfNotesController < ApplicationController
  # custom behaviour when a note is destroyed - remains on the parent ECF page
  def destroy
    @ecf_note = EcfNote.find(params[:id])
    @ecf_note.destroy
    flash[:notice] = 'Note was successfully deleted.'
    redirect_back(fallback_location: ecfs_path)
  end
end
