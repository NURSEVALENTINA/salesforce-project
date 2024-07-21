global class CreateContactsBatchJoyy implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id FROM Account LIMIT 1';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<sObject> scope) {
        List<Contact> contactsToInsert = new List<Contact>();
        for (Integer i = 1; i <= 250; i++) {
            Contact newContact = new Contact(
                FirstName = 'Contact',
                LastName = 'Record ' + i,
                Email = 'contact' + i + '@example.com',
                AccountId = ((Account)scope[0]).Id
            );
            contactsToInsert.add(newContact);
        }
        insert contactsToInsert;
    }

    global void finish(Database.BatchableContext bc) {
        // Optional finish method
    }
}