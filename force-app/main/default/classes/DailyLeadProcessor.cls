global class DailyLeadProcessor implements Schedulable {

    global void execute(SchedulableContext ctx){
        List<Lead> led = new List<Lead>();
        for(Lead l : [Select id,LeadSource from Lead WHERE LeadSource = null LIMIT 200]){
            l.LeadSource = 'Dreamforce';
            led.add(l);
        }
        update led;
    }
    
}