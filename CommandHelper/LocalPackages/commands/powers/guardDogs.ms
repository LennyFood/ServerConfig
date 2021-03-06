register_command(guarddogs, 

    array(
    
        description: 'Spawn a group of guard dogs',
        
        permission: 'ch.alias.guarddogs',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {
        
            @player = player()

            if(!is_null(import(@player."guarddogs"))){
                @oldDogs = import(@player."guarddogs")
                foreach(@uuid in @oldDogs){
                    try(entity_remove(@uuid),
                    continue())
                }
            }
            
            @dogUUIDs = spawn_mob("wolf:angry",9)
            export(@player."guarddogs",@dogUUIDs)
            set_timeout(1000,closure(
                foreach(@uuid in @dogUUIDs)
                {
                    @colors = array("WHITE", "ORANGE", "MAGENTA", "LIGHT_BLUE", "YELLOW", "LIME", "PINK", "GRAY", "SILVER", "CYAN", "PURPLE", "BLUE", "BROWN", "GREEN", "RED", "BLACK")
                    @num = rand(1,17)
                    set_entity_spec(@uuid,array(angry:true,color:@colors[@num],sitting:false))
                    tame_mob(@player,@uuid)
                }
            ))
                
        }
    )
)
