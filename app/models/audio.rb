class Audio < ActiveRecord::Base
	belongs_to :user

  def self.save_file(audio_file,user_id)
  	uploaded_io = audio_file
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)   
    end
    HardWorker.perform_async(uploaded_io.original_filename, user_id)
  end

  def self.add_audio(user_id,n)
  	user = User.find(user_id)
  	k = user.audios.all.length
   	if k > n 
    	audio = User.find(user_id).audios.last 
    	audio_name = audio.name
    	audio_id = audio.id     
   	else
    	audio_name = nil
    	audio_id = nil
   	end
   	return data = {audio_name: audio_name, id_audio: audio_id }
  end
end
