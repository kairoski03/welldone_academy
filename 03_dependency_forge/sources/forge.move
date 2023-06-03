module forge::forge {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;

    struct Sword has key, store {
        id: UID,
        magic: u64,
        strength: u64,
    }

    public entry fun sword_create(magic: u64, strength: u64, recipient: address, ctx: &mut TxContext) {
        let sword = Sword {
            id: object::new(ctx),
            magic: magic+1,
            strength,
        };
        transfer::transfer(sword, recipient);
    }
}