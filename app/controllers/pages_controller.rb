class PagesController < PublicController
  skip_before_action :ensure_logged_in

  def about
    @projects = Project.all
    @tasks = Task.all
    @memberships = Membership.all
    @users = User.all
    @comments = Comment.all
  end
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
    quote1.author = "Atom"
    quote1.quote = '"Oh man. This website is da bomb"'

    quote2 = Quote.new
    quote2.author = "Orca"
    quote2.quote = '"The functionality on this site is killer"'

    quote3 = Quote.new
    quote3.author = "Snoop"
    quote3.quote = '"I haven\'t seen such a dope web app before, yo."'

    @quotes = [quote1, quote2, quote3]

    render 'home'
  end

end
