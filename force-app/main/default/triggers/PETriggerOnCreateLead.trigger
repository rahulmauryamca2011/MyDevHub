trigger PETriggerOnCreateLead on Create__e (after insert) {
 for (Create__e event : Trigger.New) {
}
//List<Database.SaveResult> results eventbus.publis trigger.new;

}