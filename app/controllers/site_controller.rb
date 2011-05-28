class SiteController < ApplicationController
  def index
    @stations = Station.active
  end

  def tricks
    @closed_stations = Station.recently_destroyed
    @new_stations = Station.recent
  end

  def sluggify(text)
    return nil if text.blank?
    if defined?(Unicode)
      str = Unicode.normalize_KD(text).gsub(/[^\x00-\x7F]/n,'')
      str = str.gsub(/\W+/, '-').gsub(/^-+/,'').gsub(/-+$/,'').downcase
      return str
    else
      str = Iconv.iconv('ascii//translit', 'utf-8', text).to_s
      str.gsub!(/\W+/, ' ')
      str.strip!
      str.downcase!
      str.gsub!(/\ +/, '-')
      return str
    end
  end
end
