class SiteController < ApplicationController
  def index
    if !params[:city1].blank? and !params[:city2].blank?
      redirect_to "/#{sluggify(params[:city1])}-versus-#{sluggify(params[:city2])}"
      return
    end
  end

  def about
    
  end

  def tricks
    @stations = Station.moved
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
