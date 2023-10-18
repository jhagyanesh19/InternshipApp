@isTest
public class CQUI_Gj_Test_Filter_Products {
    @isTest
    static void testGetRecords() {
        // Setup Part Family test data
        compliancequest__SQX_Part_Family__c partFamily = new compliancequest__SQX_Part_Family__c(Name = 'TestFamily');
        insert partFamily;
        // Setup SQX Part test data
        compliancequest__SQX_Part__c part1 = new compliancequest__SQX_Part__c(
            Name = 'TestPart1',
            compliancequest__Part_Number__c = '12345',
            compliancequest__Part_Type__c = 'TypeA',
            compliancequest__Part_Risk_Level__c = 5,
            compliancequest__Part_Family__c = partFamily.Id // Assigning the Part Family to the Part
        );
        insert part1;
        // Test with searchTerm and part family
        Map<String, Object> currentRecord = new Map<String, Object> {
            'CQ_GJ_SQX_Part_Family_info__c' => partFamily.Id 
        };
       List<SObject> result = CQUI_GJ_Filter_Part_By_ProductFamily.getRecords(currentRecord, 'TestPart1');
        System.assertEquals(1, result.size(), 'Expected one record');
        // Test with searchTerm but without part family
        currentRecord.put('CQ_GJ_SQX_Part_Family_info__c', null);
        result = CQUI_GJ_Filter_Part_By_ProductFamily.getRecords(currentRecord, 'TestPart1');
        System.assertEquals(0, result.size(), 'Expected zero records without part family');
        // Test without searchTerm but with part family
        currentRecord.put('CQ_GJ_SQX_Part_Family_info__c', part1.compliancequest__Part_Family__c);
        result = CQUI_GJ_Filter_Part_By_ProductFamily.getRecords(currentRecord, '');
        System.assertEquals(1, result.size(), 'Expected one record without searchTerm');
    }
}