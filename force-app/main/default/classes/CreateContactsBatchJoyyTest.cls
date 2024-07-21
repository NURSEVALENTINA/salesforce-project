@isTest
private class CreateContactsBatchJoyyTest {

    @isTest
    static void testCreateContactsBatchJoyy() {
        // Create a test account record
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Start the batch job
        Test.startTest();
        CreateContactsBatchJoyy batchJob = new CreateContactsBatchJoyy();
        Database.executeBatch(batchJob);
        Test.stopTest();

        // Verify that the batch job created 250 contact records
        List<Contact> contacts = [
            SELECT Id, FirstName, LastName, Email, AccountId 
            FROM Contact 
            WHERE AccountId = :testAccount.Id
        ];
        System.assertEquals(250, contacts.size());
        for (Integer i = 0; i < 250; i++) {
            System.assertEquals('Contact', contacts[i].FirstName);
            System.assertEquals('Record ' + (i+1), contacts[i].LastName);
            System.assertEquals('contact' + (i+1) + '@example.com', contacts[i].Email);
            System.assertEquals(testAccount.Id, contacts[i].AccountId);
        }
    }
}