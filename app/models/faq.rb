class Faq

  attr_accessor :question, :answer, :id, :hashid

  def initialize(question, answer, id, hashid)
    self.question = question
    self.answer = answer
    self.id = id
    self.hashid = hashid
  end

  def self.all
    #look up what a class method is
    #self.all
    #clear array
    #explicit render
  end
end
