
$(document).on("page:change",function(){ 	
	

	if ( document.getElementById('new_audio')!= null){
		var div_all_audios = document.getElementById('all_audios')
		var all_audios = div_all_audios.getElementsByTagName('audio')
		if (all_audios.length>1){
			for(var i=0; i<all_audios.length; i++) {
				document.getElementById(all_audios[i].id).addEventListener('ended', function(){
					this.currentTime = 0;
					this.pause();
					console.log(this.id)
					for(var j=0; j<all_audios.length; j++) {
						if (all_audios[j].id == this.id && j != all_audios.length-1 ){
							document.getElementById(all_audios[j+1].id).play();
						} else if(all_audios[j].id == this.id && j == all_audios.length-1){
							document.getElementById(all_audios[0].id).play()
						}
					}
				}, false);
			}	
			
		}
		var sum = 0
		function timedCount(){
			sum +=1 
			if (sum > 10){
				clearTimeout (t)
			}
			var n = document.getElementsByTagName('audio').length
			$.ajax({
      			url: "/audio/add_new_audio",
      			type: "get",
      			data: {n: n},
      			success: function(data){ 
      				if (data.audio_name != null) {
      					var div = document.getElementById('add_audio')
						var h4 = document.createElement('h4')
						h4.innerHTML = data.audio_name
						div.appendChild(h4)
						var newlink = document.createElement('a')
						newlink.setAttribute('class', 'btn-sm');
						newlink.setAttribute('data-confirm', 'Вы уверены что хотите удалить?');
						newlink.setAttribute('data-method', 'delete');
						newlink.setAttribute('href', '/user/2/audio/'+data.audio_id);
						newlink.setAttribute('rel', 'nofollow');
						newlink.innerHTML = 'удалить'
						h4.appendChild(newlink)
						var new_audio = document.createElement('audio')
						new_audio.setAttribute('controls', 'controls');
						new_audio.setAttribute('id', 'playera'+data.audio_id);
						new_audio.setAttribute('src', '/audios/'+data.audio_name+'.mp3');
						div.appendChild(new_audio)						
						clearTimeout (t)
					}
      			}			
		    })
		}
		var t = setInterval(timedCount,5000);
		$(".btn").click(function(){
			clearTimeout (t)
		})
	}
})

