class ApplicationDecorator < Draper::Decorator

  def self.collection_decorator_class
    PaginatingDecorator
  end
  
  def number_of_people(number)
    "#{number}人"
  end

end
