trigger ContentDocTrigger on ContentDocument (before insert,before delete) {
system.debug('in delete');
}