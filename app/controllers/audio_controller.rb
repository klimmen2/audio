class AudioController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    Audio.save_file(params[:audio][:audio_file], current_user.id) 
    user = User.find_by(id:current_user.id)
    @audios = user.audios.all   
    render "user/show"
  end

  def destroy
    @audio = Audio.find(params[:id])
    @audio.destroy
    redirect_to user_path
  end

  def add_new_audio
    @data = Audio.add_audio(current_user.id, params[:n].to_i)
    p '11111111111111111111'
    p @data
    render :json => @data, status: :ok
  end

  def download_mp3
    name_file = Audio.find(params[:id]).name
    send_file("public/audios/#{name_file}.mp3",
              :filename => "#{name_file}.mp3",
              :type => "application/mp3")
  end
end
