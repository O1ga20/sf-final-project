@IsTest
public class TouristManagerTest {
    
    @TestVisible
    private static final String TOURIST_NAME = 'Olga';
    private static final Integer YEAR_ERROR = 20;
    private static final String TOURIST_LAST_NAME = 'Taras';
    private static final String TOURIST_EMAIL = 'romandlickaya@gmail.com';
    private static final String TOURIST_AGE = '5';
    static {
        TestDataFactory.createTourists();
    }
    
    @IsTest
    private static void getByName_Null_Test() {
        List<Tourist__c> touristsByName = TouristManager.getByName(null);
        
        System.assertEquals(true, touristsByName.isEmpty());
        System.assertEquals(0, touristsByName.size());
    }
    
    @IsTest
    private static void getByName_Ssuccess_Test() {
        List<Tourist__c> touristsByName = TouristManager.getByName(TOURIST_NAME);
        
        System.assertEquals(false, touristsByName.isEmpty());
        System.assertEquals(1, touristsByName.size());
    }
    
    @IsTest
    private static void getSuitableAge_Null_Test() {
        List<Tourist__c> touristsSuitableAge = TouristManager.getSuitableAge(null);
        
        System.assertEquals(true, touristsSuitableAge.isEmpty());
        System.assertEquals(0, touristsSuitableAge.size());
    }
    
    @IsTest
    private static void getSuitableAge_Ssuccess_Test() {
        List<Tourist__c> touristsSuitableAge = TouristManager.getSuitableAge(new Set<Integer> {5});
        
        System.assertEquals(false, touristsSuitableAge.isEmpty());
        System.assertEquals(2, touristsSuitableAge.size());
    }
    
    @IsTest
    private static void getByStartDateYear_Null_Test() {
        TestDataFactory.createFlights();
        List<Tourist__c> touristsByStartDateYear = TouristManager.getByStartDateYear(null);
        
        System.assertEquals(true, touristsByStartDateYear.isEmpty());
        System.assertEquals(0, touristsByStartDateYear.size());
    }
    
    @IsTest
    private static void getByStartDateYear_LengthYearNotFourDigits_Test() {        
        TestDataFactory.createFlights();
        List<Tourist__c> touristsByStartDateYear = TouristManager.getByStartDateYear(YEAR_ERROR); 
        
        System.assertEquals(true, touristsByStartDateYear.isEmpty());
        System.assertEquals(0, touristsByStartDateYear.size());
    }
    
     @IsTest
    private static void getByStartDateYear_Ssuccess_Test() {        
        TestDataFactory.createFlights();
        List<Tourist__c> touristsByStartDateYear = TouristManager.getByStartDateYear(2021);
        
        System.assertEquals(false, touristsByStartDateYear.isEmpty());
        System.assertEquals(1, touristsByStartDateYear.size());
    }
    
    @IsTest
    private static void getRegisteredOnTheTrip_Test() {
        TestDataFactory.createFlights();
        List<Tourist__c> registered = TouristManager.getRegisteredOnTheTrip();
        
        System.assertEquals(false, registered.isEmpty());
        System.assertEquals(1, registered.size()); 
    }
    
    @IsTest
    private static void getNotRegisteredOnTheTrip_Test() { 
        List<Tourist__c> notRegistered = TouristManager.getNotRegisteredOnTheTrip();
        
        System.assertEquals(false, notRegistered.isEmpty());
        System.assertEquals(3, notRegistered.size());
    }
    
    @IsTest
    private static void getTheSame_Null_Test(){
        List<Tourist__c> same = TouristManager.getTheSame(null, null);
        
        System.assertEquals(true, same.isEmpty());
        System.assertEquals(0, same.size());
    }
    
    @IsTest
    private static void getTheSame_Empty_Test(){
        List<Tourist__c> same = TouristManager.getTheSame(new Set<String> {''}, new Set<String> {''});
        
        System.assertEquals(true, same.isEmpty());
        System.assertEquals(0, same.size());
    }
    
    @IsTest
    private static void getTheSame_Ssuccess_Test(){
        List<Tourist__c> same = TouristManager.getTheSame(new Set<String> {TOURIST_LAST_NAME}, 
                                                          new Set<String> {TOURIST_EMAIL});
        
        System.assertEquals(false, same.isEmpty());
        System.assertEquals(1, same.size());
    }
    
    @IsTest
    private static void getByFlights_Null_Test() {
        List<Tourist__c> tourists = TouristManager.getByFlights(null);
        
        System.assertEquals(true, tourists.isEmpty());
        System.assertEquals(0, tourists.size()); 
    }
    
    @IsTest
    private static void getByFlights_Ssuccess_Test() {
        TestDataFactory.createFlights();
        List<Flight__c> flights = TestDataFactory.getFlights();
        List<Tourist__c> tourists = TouristManager.getByFlights(flights);
        
        System.assertEquals(false, tourists.isEmpty());
        System.assertEquals(1, tourists.size()); 
    }
    
    @IsTest
    private static void getTourists_Null_Test() {
        List<Tourist__c> touristsById = TouristManager.getTourists(null);
        
        System.assertEquals(true, touristsById.isEmpty());
        System.assertEquals(0, touristsById.size()); 
    }
    
    @IsTest
    private static void getTourists_Ssuccess_Test() {
        List<Tourist__c> tourists = TestDataFactory.getTourists();
        Set<Id> touristsId = new Set<Id> ();
        
        for (Integer i = 0; i < 3; i++) {
            touristsId.add(tourists[i].Id);
        }
        List<Tourist__c> touristsById = TouristManager.getTourists(touristsId);
        
        System.assertNotEquals(true, touristsById.isEmpty());
        System.assertEquals(3, touristsById.size());
    }
    
    @IsTest
    public static void getByNameSOSL_Null_Test() {
        List<Tourist__c> touristsByName = TouristManager.getByNameSOSL(null);
        
        System.assertEquals(true, touristsByName.isEmpty());
        System.assertEquals(0, touristsByName.size()); 
    }
    
    @IsTest
    public static void getByNameSOSL_Ssuccess_Test() {
        List<Tourist__c> tourists = TestDataFactory.getTourists();
        Id [] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = tourists[0].Id;
        System.Test.setFixedSearchResults(fixedSearchResults);
        List<Tourist__c> touristsByName = TouristManager.getByNameSOSL(TOURIST_NAME);
        
        System.assertNotEquals(true, touristsByName.isEmpty());
        System.assertEquals(1, touristsByName.size());
    }
    
    @IsTest
    public static void getSameNameAge_NullName_Test() {
        List<Tourist__c> touristsSameNameAge = TouristManager.getSameNameAge(null, TOURIST_AGE);
        
        System.assertEquals(true, touristsSameNameAge.isEmpty());
        System.assertEquals(0, touristsSameNameAge.size()); 
    }
    
    @IsTest
    public static void getSameNameAge_Ssuccess_Test() {
        List<Tourist__c> tourists = TestDataFactory.getTourists();
        Id [] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = tourists[0].Id;
        System.Test.setFixedSearchResults(fixedSearchResults);
        List<Tourist__c> touristsSameNameAge = TouristManager.getSameNameAge(TOURIST_NAME, TOURIST_AGE);
        
        System.assertNotEquals(true, touristsSameNameAge.isEmpty());
        System.assertEquals(1, touristsSameNameAge.size());
    }
}@IsTest
public class TouristManagerTest {
    
    @IsTest
    static void testGetByName() {
        TestDataFactory.createTourists();
        List<Tourist__c> touristsByName = TouristManager.getByName(null);
        System.assertEquals(new List<Tourist__c> (), touristsByName);
        touristsByName = TouristManager.getByName('Olga');
        System.assertEquals(1, touristsByName.size());
    }
    
    @IsTest
    public static void testGetSuitableAge() {
        TestDataFactory.createTourists();
        List<Tourist__c> touristsSuitableAge = TouristManager.getSuitableAge(null);
        System.assertEquals(new List<Tourist__c> (), touristsSuitableAge);
        touristsSuitableAge = TouristManager.getSuitableAge(new Set<Integer> {5});
        System.assertEquals(2, touristsSuitableAge.size());
    }
    
    @IsTest
    public static void testGetByStartDateYear() {
        TestDataFactory.createFlights();
        List<Tourist__c> touristsByStartDateYear = TouristManager.getByStartDateYear(20);
        System.assertEquals(new List<Tourist__c> (), touristsByStartDateYear);
        touristsByStartDateYear = TouristManager.getByStartDateYear(null);
        System.assertEquals(new List<Tourist__c> (), touristsByStartDateYear);
        touristsByStartDateYear = TouristManager.getByStartDateYear(2021);
        System.assertEquals(1, touristsByStartDateYear.size());
    }
    
    @IsTest
    public static void testGetRegisteredOnTheTrip() {
        TestDataFactory.createFlights();
        List<Tourist__c> registered = TouristManager.getRegisteredOnTheTrip();
        System.assertEquals(1, registered.size()); 
    }
    
    @IsTest
    public static void testGetNotRegisteredOnTheTrip() {
        TestDataFactory.createTourist(); 
        List<Tourist__c> notRegistered = TouristManager.getNotRegisteredOnTheTrip();
        System.assertEquals(1, notRegistered.size());
    }
    
    @IsTest
    public static void testGetTheSame(){
        TestDataFactory.createTourists();
        List<Tourist__c> same = TouristManager.getTheSame(null, null);
        System.assertEquals(new List<Tourist__c> (), same);
        same = TouristManager.getTheSame(new Set<String> {''}, new Set<String> {''});
        System.assertEquals(new List<Tourist__c> (), same);
        same = TouristManager.getTheSame(new Set<String> {'Taras'}, new Set<String> {'romandlickaya@gmail.com'});
        System.assertEquals(1, same.size());
    }
    
    @IsTest
    public static void testGetByFlights() {
        TestDataFactory.createTourists();
        TestDataFactory.createFlights();
        List<Flight__c> flights = TestDataFactory.getFlights();
        List<Tourist__c> tourists = TouristManager.getByFlights(null);
        System.assertEquals(new List<Tourist__c> (), tourists); 
        tourists = TouristManager.getByFlights(flights);
        System.assertEquals(1, tourists.size()); 
    }
    
    @IsTest
    public static void testGetTourists() {
        TestDataFactory.createTourists();
        List<Tourist__c> tourists = TestDataFactory.getTourists();
        Set<Id> touristsId = new Set<Id> ();
        
        for (Integer i = 0; i < 2; i++) {
            touristsId.add(tourists[i].Id);
        }
        List<Tourist__c> touristsById = TouristManager.getTourists(null);
        System.assertEquals(new List<Tourist__c> (), touristsById); 
        touristsById = TouristManager.getTourists(touristsId);
        System.assertEquals(2, touristsById.size());
    }
    
    @IsTest
    public static void testGetByNameSOSL() {
        TestDataFactory.createTourists();
        List<Tourist__c> tourists = TestDataFactory.getTourists();
        Id [] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = tourists[0].Id;
        System.Test.setFixedSearchResults(fixedSearchResults);
        List<Tourist__c> touristsByName = TouristManager.getByNameSOSL(null);
        System.assertEquals(new List<Tourist__c> (), touristsByName);
        touristsByName = TouristManager.getByNameSOSL('Olga');
        System.assertEquals(1, touristsByName.size());
    }
    
    @IsTest
    public static void testGetSameNameAge() {
        TestDataFactory.createTourists();
        List<Tourist__c> tourists = TestDataFactory.getTourists();
        Id [] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = tourists[1].Id;
        System.Test.setFixedSearchResults(fixedSearchResults);
        List<Tourist__c> touristsSameNameAge = TouristManager.getSameNameAge(null, '5');
        System.assertEquals(new List<Tourist__c> (), touristsSameNameAge);
        touristsSameNameAge = TouristManager.getSameNameAge('Ira', '20');
        System.debug(touristsSameNameAge);
        System.assertEquals(1, touristsSameNameAge.size());
    }
}