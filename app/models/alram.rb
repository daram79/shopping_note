class Alram < ActiveRecord::Base
  belongs_to :alram, :polymorphic => true
end
