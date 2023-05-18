module object_owner::object_owner {
    use std::string;
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct Parent has key {
        id: UID,
    }

    struct Child has key, store {
        id: UID,
        name: string::String,
    }

    public entry fun create_parent(ctx: &mut TxContext) {
        let parent_id = object::new(ctx);
        let parent = Parent {
            id: parent_id,
        };
        transfer::transfer(parent, tx_context::sender(ctx));
    }

    public entry fun transfer_child(receiver: address, ctx: &mut TxContext) {
        let child = Child { id: object::new(ctx),name: string::utf8(b"transferring child") };
        transfer::transfer(child, receiver);
    }

}
