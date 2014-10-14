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

end
