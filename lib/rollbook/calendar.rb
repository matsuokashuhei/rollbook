module Rollbook

  module Calendar
    
    def self.workday?(date)
      holiday?(date).!
    end

    def self.holiday?(date)
      Holiday.exists?(date: date)
    end

  end

end