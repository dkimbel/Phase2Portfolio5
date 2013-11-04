class Event < ActiveRecord::Base
  validates :date, :organizer_name, :title, :presence => true
  validates :title, :uniqueness => true
  validates :organizer_email, :format => { :with => /\w+@\w+\.\w{2,}/ }
  validate :date_cannot_be_in_past

  def date_cannot_be_in_past
    begin
      if (self.date - Date.today < 0)
        errors.add(:date, "cannot be in the past.")
      end
    rescue NoMethodError
    end
  end
end