class PagesController < ApplicationController

  def home
    @entries = Entry.recent
  end
end
