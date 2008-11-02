class Contact < ActiveRecord::Base

  # FIXME: something is causing first_name to be sent
  #        sometimes and last_name others

  def first_name=(val)
    self.firstName = val
  end

  def last_name=(val)
    self.lastName = val
  end

end
