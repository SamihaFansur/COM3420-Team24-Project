class SearchController < ApplicationController

    def index
        @ecfs = Ecf.all
        @affected_units = AffectedUnit.all
    end



end