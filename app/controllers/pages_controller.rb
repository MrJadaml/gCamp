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

    quote1 = Quote.new
    quote1.author = "-Atom"
    quote1.quote = '"You da bomb"'

    quote2 = Quote.new
    quote2.author = "-Orca"
    quote2.quote = '"This site looks killer"'

    quote3 = Quote.new
    quote3.author = "-Snoop"
    quote3.quote = '"What a dope page"'

    @quotes = [quote1, quote2, quote3]

    render 'home'
  end

end
