require 'mail'

class Request < ActiveRecord::Base
  attr_accessible :part, :description, :qty, :closed, :name
  
  validates :part, :presence => true
  validates :name, :presence => true
  validates :qty, :presence => true, :numericality => { :greater_than => 0 }
  
  def self.average_mins
    records = where( "DATE(created_at) = DATE(?)", Time.zone.now ).where( closed: true )
    return '0' if records.empty?
    '%.2f' % ( records.inject(0) { |sum, record| sum + ( record[:updated_at] - record[:created_at] ) }.to_f / records.count / 60 )

  end
  
end
