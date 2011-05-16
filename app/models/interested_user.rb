class InterestedUser
  include MongoMapper::Document

  key :email, String, :unique => true, :required => true, :index => true
  timestamps!
  
  validates_length_of :email, :within => 5..100, :allow_nil => false
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end