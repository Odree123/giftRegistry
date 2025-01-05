// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
contract giftRegistry{
    //structure to represent a gift

    struct Gift{
        //Name of gift
        string name;
        //price of gift
        uint price;
        //address of the person who purchaed the gift
        address buyer;
        //indicate if the gift is purchased
        bool isPurchased;
    }
    // array to store gifts in the registry
    Gift[] public gifts;

    //event emitted when a gift is added
    event GiftAdded(string name, uint price);

    //event emitted when a gift is purchased
    event GiftPurchased(uint giftIndex, address buyer);

    function addGift(string memory _name, uint _price) public{
        /***@dev add a gift to the registry
        @param _name of the gift
        @param _price of the gift in wei
        */
        require(bytes(_name).length>0 ,"Gift name must not be empty");
        require(_price >0 ,"Gift price must be greater than 0");
    
    gifts.push(Gift({
        name: _name,
        price: _price,
        buyer: address(0),
        isPurchased: false
    }));

    emit GiftAdded(_name,_price);

}
//payable where money moves in the blockchain
/***@dev purchase a gift from a registry
@param _i
*/
function purchaseGift(uint _Index) public payable {
    require(_Index<gifts.length,"Gifts does not exist");

    Gift storage gift= gifts[_Index];
    require(!gift.isPurchased, "Gift is already purchased");
    require(msg.value >= gift.price,"insufficient funds to purchase");

      gift.isPurchased=true;
      gift.buyer=msg.sender;

      emit GiftPurchased(_Index,msg.sender);

}



function getGiftCount()public view returns(uint){
    return gifts.length;
}

function getGift(uint _index)public view returns(string memory,uint,address,bool){
 require(_index <gifts.length,"Gift does not exist"); 
 Gift storage gift= gifts[_index];
 return(gift.name,gift.price, gift.buyer,gift.isPurchased);

}




}