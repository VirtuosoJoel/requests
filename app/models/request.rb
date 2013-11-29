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
  
  def send_complete_email

    qty, part, name, updated_at = self.qty, self.part, self.name, self.updated_at
  
    options = { :address              => "mail.centrexservices.co.uk",
                :port                 => 25,
                :user_name            => 'Automatic.Emailer',
                :password             => '***',
                :authentication       => 'plain',
                :enable_starttls_auto => true }
    
    Mail.defaults do
      delivery_method :smtp, options
    end

    Mail.deliver do
        from 'Automatic.Emailer@centrexservices.co.uk'
        to 'mkstores@centrexservices.co.uk'
        subject( 'Requests Program: ' + qty.to_s + ' x ' + part + ' for ' + name )
        body( qty.to_s + ' x ' + part + ' delivered to ' + name + ' at ' + updated_at.localtime.to_s )
    end

  end
  
  
end
