
// SPDX-License-Identifier: MIT
pragma solidity >=0.8;


contract nftMarketPlace{


     //admin
      address payable  private  admin;

     //nft details struct / nft address , nftToken id, seller address , uint price , bool isSold

     struct nftDetails{
        
        address nftAddress;
        uint nftTokenID;
        address seller;
        uint price;
        bool isSold;

     }
     //list of nfts

     nftDetails [] listOfAllNfts; 
     
     //constructor

     constructor(){
        admin=payable (msg.sender);
        comissionPercentage=10;

     }

     // admin comission
     uint public comissionPercentage;
      

     //add nft details

     function addNft(address  nftAddress, uint nftTokenId ,   uint price )public {
         
         //require nft!=0 , tokenId!=0, isSold=false , seller address !=0
         require(nftAddress!=address(0), 'address should not be zero');
              require(nftTokenId!=0, 'tokenid should not be zero');
                  require(price!=0, 'price should not be zero');
              
         
         nftDetails memory newNft=nftDetails(nftAddress, nftTokenId , msg.sender , price*1 ether , false);
         listOfAllNfts.push(newNft);
     }


      

     //get nft details

     function getNftDetails(uint nftIndex) public  view returns (nftDetails memory){
    
     require(listOfAllNfts.length>0,'no nft avialable at   moment');
    return  listOfAllNfts[nftIndex];
          
     }



     //buy nft 

     function buyNft(uint nftIndex) public payable {

         require(nftIndex<listOfAllNfts.length , 'nft index cannot be zero');
         nftDetails storage currentNft=listOfAllNfts[nftIndex];
         require(currentNft.isSold==false , 'nft alreadt sold');
         require(currentNft.seller!=msg.sender, 'buyer and seller cannot be equal');
         require(msg.sender!=admin , "admin cannot buy nft");
       
        require(msg.value==currentNft.price  ,"price should be equal");
      //   payable ( address(this)).transfer(msg.value);
         uint adminComission=(currentNft.price*comissionPercentage)/100;
         admin.transfer(adminComission); 
         payable (currentNft.seller).transfer(currentNft.price-adminComission);
         currentNft.isSold=true;
         currentNft.nftAddress=msg.sender;
     }


     //admin withdrawl

     function withdrawFund(uint amount) public {

      // uint contractBalance=address(this).balance;
      admin.transfer(amount);
     }

    

   


     
}



