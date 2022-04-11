class EcfNotesController < ApplicationController
  def destroy
    @ecf_note = EcfNote.find(params[:id])
    @ecf_note.destroy
    flash[:notice] = 'Note was successfully deleted.'
    redirect_back(fallback_location: ecfs_path)
  end
end