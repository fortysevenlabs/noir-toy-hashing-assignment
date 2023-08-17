global PRIME: u32 = 16777619;

fn main(value: u32, hash_value: pub u32){
    let calculated_hash_value = calculate_hash(value);

    assert(calculated_hash_value == hash_value);
}

fn calculate_hash(num: u32) -> u32 {
    // FNV values | https://en.wikipedia.org/wiki/Fowler%E2%80%93Noll%E2%80%93Vo_hash_function
    let mut hash_value = 0x811c9dc5;    // 2166136261
    let size = 0xffffffff;              // 4294967296

    // data
    let num_field = num as Field;
    let num_bytes = num_field.to_be_bytes(4);

    // hash calc
    for byte in 0..4 {
        let product = (hash_value * PRIME) % size;          // mul
        hash_value = product ^ num_bytes[byte] as u32;      // xor
    }

    hash_value
}

#[test]
fn test_1() {
    let num = 127561628;
    let hash = calculate_hash(num);

    assert(hash == 0x71233de7);
}

#[test]
fn test_2() {
    let num = 237261828;
    let hash = calculate_hash(num);

    assert(hash == 0x7F51D567);
}

#[test]
fn test_3() {
    let num = 596214892;
    let hash = calculate_hash(num);

    assert(hash == 0x3F0C8995);
}
