module forge_caller::forge_caller {
    use forge::forge;

    use sui::tx_context::TxContext;

    public entry fun sword_create_call(magic: u64, strength: u64, recipient: address, ctx: &mut TxContext) {
        forge::sword_create(magic, strength, recipient, ctx);
    }
}