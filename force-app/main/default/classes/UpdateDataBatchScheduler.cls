global class UpdateDataBatchScheduler implements Schedulable {
    global void execute(SchedulableContext ctx) {
       database.executebatch(new UpdateDataBatch());
    }
}