trigger testing on Account (before update) {
    
    for(Account a : trigger.new){
        if(trigger.oldmap.get(a.id).name != a.name){
            a.description = 'value is changed from '+ trigger.oldmap.get(a.id).name +'to '+a.name;
        }
    }
    
}