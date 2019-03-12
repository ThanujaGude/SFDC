public class Bankruptcy_Buildout_MJ {
    
     @AuraEnabled
    public static Bankruptcy__c getbk(ID artId){
        Bankruptcy__c bankruptcy=[select Id,Name,Loan_Master__c from Bankruptcy__c where id =:artId];
        return bankruptcy;
    }
      @AuraEnabled
    public static Bankruptcy_Referral__c getbkr(ID artId){
        Bankruptcy__c bankruptcy=[select Id,Name,Loan_Master__c from Bankruptcy__c where id =:artId];
        try{
        Bankruptcy_Referral__c bkr1=[select Id,Bankruptcy__c,Referral_Status__c,Managed_by__c,RecordType.Name,CreatedById from Bankruptcy_Referral__c where Bankruptcy__c =:artId limit 1];
            return bkr1;}
        catch(exception e){
            return null;
        }
    }
    @AuraEnabled
    public static void recordcreation(ID artId,String bktype,String manageby)
    {
         Bankruptcy__c bankruptcy=[select Id,Name,Loan_Master__c from Bankruptcy__c where id =:artId];
         
         
         
        Bankruptcy_Referral__c bkref = new Bankruptcy_Referral__c();
        bkref.Name = bankruptcy.Name;
       bkref.Managed_by__c=manageby;
         bkref.Mortgage__c = bankruptcy.Loan_Master__c;
         bkref.Bankruptcy__c = bankruptcy.Id;
        if(bktype=='Loss Mitigation')
        {
          bkref.RecordTypeId ='01246000000DyxEAAS' ; 
        }
        else if(bktype=='Amended Proof of Claim'){
            bkref.RecordTypeId ='01246000000DyxDAAS' ;
        }
        else if(bktype=='Motion To Approve Loan Modification'){
            bkref.RecordTypeId ='01246000000DyxIAAS' ;
        }
         else if(bktype=='Motion To Allow Late Claim'){
            bkref.RecordTypeId ='01246000000DyxHAAS' ;
        }
        else if(bktype=='Miscellaneous Objection'){
            bkref.RecordTypeId ='01246000000DyxFAAS' ;
        }
         else if(bktype=='Motion For Relief'){
            bkref.RecordTypeId ='01246000000DyxGAAS' ;
        }
        else if(bktype=='Notice of Payment Change'){
            bkref.RecordTypeId ='01246000000DyxJAAS' ;
        }
        else if(bktype=='Past Petition Fee Notice'){
            bkref.RecordTypeId ='01246000000DyxKAAS' ;
        }
         else if(bktype=='Response To Final Cure'){
            bkref.RecordTypeId ='01246000000DyxNAAS' ;
        }
        
        else if(bktype=='Transfer of Claim'){
            bkref.RecordTypeId ='01246000000DyxOAAS' ;
        }
         else if(bktype=='Proof of Claim'){
            bkref.RecordTypeId ='01246000000DyxMAAS' ;
        }
        else if(bktype=='Plan Objection'){
            bkref.RecordTypeId ='01246000000DyxLAAS' ;
        }
        
      
        insert bkref;
    }
    
     @AuraEnabled
     
    	public static BK_Referral_Wrapper get_Wrapper(ID artId){
    	    
    	     Bankruptcy__c bankruptcy=[select Id,Name,Loan_Master__c from Bankruptcy__c where id =:artId];
       
        List<Bankruptcy_Referral__c> bkr_list =[select Id,Bankruptcy__c,Referral_Status__c,Managed_by__r.Name,RecordType.Name,CreatedBy.Name from Bankruptcy_Referral__c where Bankruptcy__c =:artId limit 5];
        
    	    BK_Referral_Wrapper bkrw = new BK_Referral_Wrapper(null);
    	    List<BK_Referral> referral_list = new List<BK_Referral>();
    	    if(bkr_list.size()>0){
    	        
    	        for(Bankruptcy_Referral__c br:bkr_list){
    	            BK_Referral bkr = new BK_Referral(br.Id,br.RecordType.Name,br.Referral_Status__c,br.CreatedBy.Name,br.Managed_by__r.Name);
    	            referral_list.add(bkr);
    	        }
    	        
    	        bkrw.BK_Referral_List=referral_list;
    	        
    	        
    	    }
    	    
    	    return bkrw;
    	    
    	}
    
    
public class BK_Referral_Wrapper{
    	    
    	     @AuraEnabled
            public List<BK_Referral> BK_Referral_List{get;set;}
            
    	       public BK_Referral_Wrapper(List<BK_Referral> BK_Referral_List){
                this.BK_Referral_List = BK_Referral_List;
                
            }
    	}
    
    
    public class BK_Referral{
        
          @AuraEnabled
            public Id recId{get;set;} 
         @AuraEnabled
            public String recordtypename{get;set;} 
       
          @AuraEnabled
            public string status{get;set;} 
              @AuraEnabled
            public string Initiated{get;set;} 
             @AuraEnabled
            public string managed{get;set;} 
            
            
            public BK_Referral(Id recId,String recordtypename, string status, string Initiated, string managed)
            {
                this.recId=recId;
                 this.recordtypename=recordtypename;
                  this.status=status;
                   this.Initiated=Initiated;
                    this.managed=managed;
                
            }
        
    }
    }