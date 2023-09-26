trigger CandidateApexTriggerHandler on Candidate__c (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        //fire then the trigger when type is isInsert and isAfter
        CandidateApexTriggerContainer.handle(Trigger.new);
    }

}