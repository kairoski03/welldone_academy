module abc_coin::abc_coin {
    use sui::balance::{Self, Supply};
    use sui::coin::{Self, Coin};
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::types;

    struct ABC has drop {}

    struct AbcTreasuryCap has key {
        id: UID,
        total_supply: Supply<ABC>,
        isOtw: bool
    }

    fun init(ctx: &mut TxContext) {
        let total_supply = balance::create_supply<ABC>(ABC {});
        transfer::share_object(AbcTreasuryCap{
            id: object::new(ctx),
            total_supply,
            isOtw: true
        });

        let total_supply2 = balance::create_supply<ABC>(ABC {});
        transfer::share_object(AbcTreasuryCap{
            id: object::new(ctx),
            total_supply: total_supply2,
            isOtw: true
        });
    }

    // public fun create_supply<T: drop>(_: T): Supply<T> {
    //     Supply { value: 0 }
    // }

    public entry fun mint(
        cap: &mut AbcTreasuryCap, amt: u64, ctx: &mut TxContext
    ) {
        let minted_balance = balance::increase_supply(&mut cap.total_supply, amt);
        let minted_coin = coin::from_balance(minted_balance, ctx);
        transfer::public_transfer(minted_coin, tx_context::sender(ctx));
    }

    public entry fun burn(
        cap: &mut AbcTreasuryCap, basket: Coin<ABC>
    )  {
         balance::decrease_supply(&mut cap.total_supply, coin::into_balance(basket));
    }

    public entry fun createWitness(cap: &mut AbcTreasuryCap) {
        let isOtw = types::is_one_time_witness(&ABC {});
        cap.isOtw = isOtw;
    }

}