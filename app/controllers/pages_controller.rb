class PagesController < ApplicationController

  def index
    render 'home'
  end

  def about
  end

  def terms
  end

  def test
    @current_time = Time.now
  end

end


# {title: Tasks, item: Grouped by projects and lists. Just the way you like em.}, {title: Documents, item: }
