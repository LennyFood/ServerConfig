register_command(mutate, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.mutate',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
        tabcompleter: closure(@alias, @sender, @args) {
            try{
                if(array_size(@args) == 0) {
                    return(all_players());
                }
                @search = @args[array_size(@args) - 1];
                    return(array_filter(all_players(), closure(@index, @player) {
                    return(equals_ic(@search, substr(@player, 0, length(@search))));
                }));
            } catch (RangeException @ErrorInfo) {
                # Ignore
            }
        },
    
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /mutate <player>');
                die(); # No need to go further					
            
            }
            
            @plr = player()

            @vic = @args[0]
            @vic = player(@vic)
            @ploc = ploc()
            @vicLoc = ploc(@vic)

            @x1 = @ploc['x']
            @y1 = @ploc['y']
            @z1 = @ploc['z']

            @x2 = @vicLoc['x']
            @y2 = @vicLoc['y']
            @z2 = @vicLoc['z']

            @x3 = pow(@x1 - @x2, 2)
            @y3 = pow(@y1 - @y2, 2)
            @z3 = pow(@z1 - @z2, 2)

            @final = @x3 + @y3 + @z3

            @final = sqrt(@final)
           
            if(@final >= 10){
                tmsg(@plr,color(red).'Sorry, that player is not close enough.')
                die()
            }

            assign(@cooldown, 60)
            
            assign(@lastUsedMutate, import(@plr."lastUsedMutate"))
            if(@lastUsedMutate + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedMutate, @cooldown), divide(time(),1000)))
                tmsg(@plr,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use flame again!'))
                die()
            )
            export(@plr."lastUsedMutate", time() / 1000)

            include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
            _mortal(@player)

            include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')
            set_timeout(5000,closure(
                _changeSkin(@vic,'qiXdnqmrX6a/mmN1vgjSM3hp7lKWCv59ZKvejEST003uj/0b+Pu2cMyHyy4QW2F7pCZrJnak85AP9bbdi1tw6QB+2AlP1SJsgrv3wLIsJNnm6q3eRRfzW6fZAkB13HZvj1no1EztAtrWKgzi2qrdDN4vf7E9+P1IFWI1+DMjC3IP8AVsz9UVg9LF8J+/K2nddFYXbv4ztiabFZIj2lTVRmrR5DD8MIBZ0KxqVd/PxH7qBu1MrxRK9HyeP2ueWjncyWf5m1jh6ssa8e2rTRoRi35dybP7+B0N9t/A3iK4EYv5qh92e5QQ5u779cya6kWTmslH8wn3WBCKtfeMfeKBy9wuSSOfTdMDIWU9BFt8UFkzaUxraj7bSEWJjgjUt4lSTDIb0gDm0tGO8951MaHUIeDSfQUyn/RMg5oOL1Ktom+OGlhD9Bpa7O/pHtYKIyOETICHeyvoEENT1gGWWynZjkMOsYwI/eaSPcA8mpdhRMt1ZA8E0SHCFMPZPu5rgaVTmrRXymEsVh/jT689f97I13HCcnRmascxrCANhVEKao1/OISNZ+VTcl7BWEz+Z3XFuWAFJv/47fojH03l+v5vU+jX1DFg/LIWtfO1Zv3QlSHWk9GOCBrUWn3X0gMInmLr3hlwAc2I7BQC/WVQdxcgTGumdcu+XidAyT7UJadyc5c=','eyJ0aW1lc3RhbXAiOjE0NzcwMTI0NjA4MjgsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzRmNzI1ZDI4NTY4OGUyN2QyYmMzNTcxMWRlNGY3MTNmYzUxOTQ0MjM5MzJlYmZlMDViMjhjZTljNzJmOWZiZCJ9fX0=')
            ))
            
        }
    )
)
