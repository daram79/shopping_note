class MainFeed < ActiveRecord::Base
  belongs_to :main, :polymorphic => true
end
