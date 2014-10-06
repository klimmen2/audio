class HardWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

def perform(original_filename, id_user)	
    file_extension = original_filename.slice(/\.\w+\z/).length
    name_file = original_filename[0..-(file_extension+1)]
    movie = FFMPEG::Movie.new("public/uploads/#{original_filename}")
    movie.transcode("public/audios/#{name_file}.mp3")
    user = User.find_by(id:id_user)
    audio = Audio.new
    audio.name = name_file
    user.audios << audio
    user.save
end


end