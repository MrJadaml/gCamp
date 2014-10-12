class PagesController < ApplicationController

  def index
    @col = [
      {
        img: "nycimg1.jpg",
        title: "Tasks",
        item: ['Grouped by projects and lists. Just the way you like \'em.']
      },
      {
        img: "nycimg2.jpg",
        title: "Documents",
        item: ['Upload', 'Comment', 'Revise']
      },
      {
        img: "nycimg3.jpg",
        title: "Comments",
        item: ['Comment on tasks document', 'Get email notification']
      }
    ]
    render 'home'
  end

  def about
  end

  def terms
  end


end

# @titles = [
#   ['Tasks', ["Grouped by projects and lists. Just the way you like \'em."], "nycimg1.jpg"],
#   ['Documents', ["Upload", "Comment", "Revise"], "nycimg2.jpg"],
#   ['Comments', ["Comment on tasks document", "Get email notification"], "nycimg3.jpg"]
# ]
