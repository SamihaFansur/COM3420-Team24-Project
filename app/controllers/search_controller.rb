class SearchController < ApplicationController

    def index
        @q = Ecf.ransack(params[:q])
        @ecfs = @q.result
    end



end