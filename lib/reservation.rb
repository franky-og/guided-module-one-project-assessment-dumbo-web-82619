class Reservation < ActiveRecord::Base
    belongs_to :user
    belongs_to :restaurant

    
    # def self.tty_prompt
    #     prompt = TTY::Prompt.new
    # end
    
    
    
end