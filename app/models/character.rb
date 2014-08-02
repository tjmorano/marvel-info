require 'httparty'
require 'digest/md5'

BASE_URI="http://gateway.marvel.com/v1/public/"

class Character 
  include HTTParty

  def self.find(id)
    uri = get_uri(0, 1, id)
    HTTParty.get(uri)
  end

  def self.response(offset=0, limit=20)
    uri = get_uri(offset, limit)
    HTTParty.get(uri)
  end

  private

  def self.get_uri(offset, limit, id=nil)
    public_key = ENV['MARVEL_PUBLIC_KEY']
    private_key =  ENV['MARVEL_PRIVATE_KEY']
    ts = Time.now.to_i
    hash = Digest::MD5.hexdigest(ts.to_s+private_key+public_key)
    if id
      BASE_URI+"characters/"+id+"?ts="+ts.to_s+"&apikey="+public_key+
        "&hash="+hash+"&offset="+offset.to_s+"&limit="+limit.to_s
    else
      BASE_URI+"characters?ts="+ts.to_s+"&apikey="+public_key+
        "&hash="+hash+"&offset="+offset.to_s+"&limit="+limit.to_s
    end
  end
end
