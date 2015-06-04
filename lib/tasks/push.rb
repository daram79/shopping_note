#encoding: utf-8
# require 'gcm'
# require "/Users/shimtong1004/work/shopping_note/config/environment.rb"
# gcm = GCM.new("AIzaSyDyxck6hFnEtoBkTz3FNdvme3w3csLdTWA")
# # you can set option parameters in here
# #  - all options are pass to HTTParty method arguments
# #  - ref: https://github.com/jnunemaker/httparty/blob/master/lib/httparty.rb#L40-L68
# #  gcm = GCM.new("my_api_key", timeout: 3)
# # an array of one or more client registration IDs
# registration_ids = ["APA91bGzgf0igOh3MaZ0CuMAxPAmjdtgZxv38zDfcBLWB5cSl8m-wIzTiD9osRfkHjQxUG-xR5h8slohF_cARwduUUUmO2OBHfQR11OB4wH1P7s7OYakhxmjrODNR-LRAPIJgbYofZ7e"]
# options = {data: {friend_user_name: "심희동", alram_type: "Like"}}
# # options = {type: "Like", friend_user_name: "aaa"}
# response = gcm.send(registration_ids, options)
# p response

require 'gcm'
require "#{File.dirname(__FILE__)}/../../config/environment.rb"

alrams = Alram.where(send_flg: false)

unless alrams.blank?
  gcm = GCM.new("AIzaSyDyxck6hFnEtoBkTz3FNdvme3w3csLdTWA")
      # registration_ids = [self.alram.last.user.registration_id]
      # options = {data: {friend_user_name: self.alram.last.friend_user.nick, alram_type: "Comment"}}
      # response = gcm.send(registration_ids, options)
  registration_id = []
  alrams.each do |alram|
    registration_id[0] = alram.user.registration_id
    name = alram.friend_user.nick
    type = alram.alram_type
    options = {data: {friend_user_name: name, alram_type: type}}
    begin
      response = gcm.send(registration_id, options)
      alram.update(send_flg: true)
      # p response
    rescue
    end
  end
end
