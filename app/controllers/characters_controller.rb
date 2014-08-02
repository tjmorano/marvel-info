class CharactersController < ApplicationController

  before_filter :authenticate_user!, :except => [:some_action_without_auth]

  def show
    session[:last_page] = request.env['HTTP_REFERER'] || characters_path
    @response = Character.find(params[:id])
  end

  def index
    if params[:offset]
      offset = params[:offset].to_i
    else
      offset = 0
    end
    if params[:limit]
      limit = params[:limit].to_i
    else
      limit = 20
    end
    @response = Character.response(offset, limit)
  end
end
