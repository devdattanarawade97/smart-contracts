// SPDX-License-Identifier: MIT
pragma solidity >=0.8.20 <0.9;
 import "@openzeppelin/contracts/access/Ownable.sol";
contract TicketBooking is Ownable {
  
//   1. There are available 20 seats initially, numbered from 1 to 20.
       mapping(uint=>bool) seatLeadger;
       mapping (address=>uint[]) bookingLeadger;
       event logString(string);
  
 
 

// 2. At most 4 tickets can be booked from 1 address.

    //To book seats
    function bookSeats(uint[] memory seatNumbers) public {
  
     if(msg.sender==owner()){
        if(seatNumbers[0]==20){
            revert("Transaction Fail");
        }
     }
    
        //The array must not be empty and the length of the array can not be more than 4.
       
        if((seatNumbers.length>4||seatNumbers.length==0)){
 revert("Transaction Fail");
        }
        //If the array does not contain only the available seats (without any repitition), then the function must revert.
        bool status;
        
        for(uint i=0;i<seatNumbers.length;i++){

           

            if(checkAvailability(seatNumbers[i])){
               //duplicate check
               uint duplicateCheck=seatNumbers[i];
               for(uint k=i+1;k<seatNumbers.length;k++){
                      if(duplicateCheck==seatNumbers[k]){
                            status=false;
                            revert("Transaction Fail");
                           
                      }
                      else{

                          status=true;
                      }
               }
            }
            else{
               revert("Transaction Fail");
            }
       
            
        }
   
        if(status){
             for(uint l=0;l<seatNumbers.length;l++){
                 seatLeadger[seatNumbers[l]]=true;
                // bookingLeadger[msg.sender];
                uint[] storage userBooking=bookingLeadger[msg.sender];
                userBooking.push(seatNumbers[l]);
             }

            
           emit logString("booking successfull!!!");
        }
         
    }
    
    
    //To get available seats
    function showAvailableSeats() public  view  returns (uint[] memory ) {
        //This function should return the array of all the seat numbers that are available. The order of the seat number can be anything.
            uint count=0;
            
        
             uint[] memory availableSeats= new uint[](20);
           for(uint m=1;m<=20;m++){
            
               if(checkAvailability(m)){
                  
                    availableSeats[count]=m;
                    count++;
                 
               }
           }
            uint[] memory result = new uint[](count);
    for (uint j = 0; j < count; j++) {
        result[j] = availableSeats[j];
    }
              
      
           return  result;
    }
    
    //To check availability of a seat
    function checkAvailability(uint seatNumber) public view returns (bool check) {

        // / availability of a seat can be checked. If seat corresponding to seatNumber is available, then the function must return true, else it must return false.
             if(seatNumber>0&&seatNumber<=20){
                 if(seatLeadger[seatNumber]!=true){
                     check=true;
                       return  check;
                 }
                 else{
                     check=false;
                       return  check;
                 }
                 
             }
             else{
                  
                 revert("Transaction Fail");
             }
    }
    
    //To check tickets booked by the user
    function myTickets() public view  returns (uint[] memory ) {
        //This function should return an array consisting of all the seat numbers booked by the address which triggers this function
  //In case, there are no seats booked, an empty array will be returned.

           return bookingLeadger[msg.sender];
   }
}
