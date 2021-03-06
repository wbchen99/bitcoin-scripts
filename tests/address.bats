#!/usr/bin/env bats

. ../inc.common.sh

@test "P2PKH mainnet address validation" {
    testnet=0
    addresses=()
    addresses+=("1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2")

    for i in $(seq 0 $(( ${#addresses[@]} - 1 )) ); do
        is_valid_bitcoin_address ${addresses[$i]}
        is_p2pkh_bitcoin_address ${addresses[$i]}
        [[ "$(get_bitcoin_address_type ${addresses[$i]})" == "p2pkh" ]]
    done
}

@test "P2PKH testnet address validation" {
    testnet=1
    addresses=()
    addresses+=("ms4VLdD9sFGMureHo378jziwKKjx3uKZLw")

    for i in $(seq 0 $(( ${#addresses[@]} - 1 )) ); do
        is_valid_bitcoin_address ${addresses[$i]}
        is_p2pkh_bitcoin_address ${addresses[$i]}
        [[ "$(get_bitcoin_address_type ${addresses[$i]})" == "p2pkh" ]]
    done
}

@test "P2SH mainnet address validation" {
    testnet=0
    addresses=()
    addresses+=("3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy")
    addresses+=("3QJmV3qfvL9SuYo34YihAf3sRCW3qSinyC")

    for i in $(seq 0 $(( ${#addresses[@]} - 1 )) ); do
        is_valid_bitcoin_address ${addresses[$i]}
        is_p2sh_bitcoin_address ${addresses[$i]}
        [[ "$(get_bitcoin_address_type ${addresses[$i]})" == "p2sh" ]]
    done
}

@test "P2SH testnet address validation" {
    testnet=1
    addresses=()
    addresses+=("2N41z1ZYTZ6WVzcw7nDaJKh421bhM2v6Bak")

    for i in $(seq 0 $(( ${#addresses[@]} - 1 )) ); do
        is_valid_bitcoin_address ${addresses[$i]}
        is_p2sh_bitcoin_address ${addresses[$i]}
        [[ "$(get_bitcoin_address_type ${addresses[$i]})" == "p2sh" ]]
    done
}

@test "Bech32 mainnet address validation" {
    testnet=0
    addresses=()
    addresses+=("BC1QW508D6QEJXTDG4Y5R3ZARVARY0C5XW7KV8F3T4")
    addresses+=("bc1pw508d6qejxtdg4y5r3zarvary0c5xw7kw508d6qejxtdg4y5r3zarvary0c5xw7k7grplx")
    addresses+=("BC1SW50QA3JX3S")
    addresses+=("bc1zw508d6qejxtdg4y5r3zarvaryvg6kdaj")

    for i in $(seq 0 $(( ${#addresses[@]} - 1 )) ); do
        is_valid_bitcoin_address ${addresses[$i]}
        is_bech32_bitcoin_address ${addresses[$i]}
        [[ "$(get_bitcoin_address_type ${addresses[$i]})" == "bech32" ]]
    done

    # Invalid
    addresses=()
    # Empty data section (too short)
    addresses+=("bc1gmk9yu")

    for i in $(seq 0 $(( ${#addresses[@]} - 1 )) ); do
        ! is_valid_bitcoin_address ${addresses[$i]}
    done
}

@test "Bech32 testnet address validation" {
    testnet=1
    addresses=()
	addresses+=("tb1qrp33g0q5c5txsp9arysrx4k6zdkfs4nce4xj0gdcccefvpysxf3q0sl5k7")
	addresses+=("tb1qqqqqp399et2xygdj5xreqhjjvcmzhxw4aywxecjdzew6hylgvsesrxh6hy")

    for i in $(seq 0 $(( ${#addresses[@]} - 1 )) ); do
        is_valid_bitcoin_address ${addresses[$i]}
        is_bech32_bitcoin_address ${addresses[$i]}
        [[ "$(get_bitcoin_address_type ${addresses[$i]})" == "bech32" ]]
    done

    # Invalid
    addresses=()
    # Mixed case
    addresses+=("tb1qrp33g0q5c5txsp9arysrx4k6zdkfs4nce4xj0gdcccefvpysxf3q0sL5k7")

    for i in $(seq 0 $(( ${#addresses[@]} - 1 )) ); do
        ! is_valid_bitcoin_address ${addresses[$i]}
    done
}

