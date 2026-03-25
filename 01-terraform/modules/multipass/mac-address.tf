resource "random_id" "address_bytes" {
  count = var.instance_count
  # A MAC address is 6 bytes (48 bits)
  byte_length = 6
}

# https://serverfault.com/a/40720
resource "random_shuffle" "second_char" {
  # Set the second hexadecimal digit to "2" to ensure it's a locally administered unicast address (0x02)
  # The first byte's value is bitwise ANDed with 0xFE (clear multicast bit) and bitwise ORed with 0x02 (set local bit)
  input        = ["2", "6", "A", "E"]
  result_count = var.instance_count
}

locals {
  mac_address = [
    for i in range(var.instance_count) :
    upper(format(
      "%s%s:%s:%s:%s:%s:%s",
      substr(random_id.address_bytes[i].hex, 0, 1),
      random_shuffle.second_char.result[i],
      substr(random_id.address_bytes[i].hex, 1, 2),
      substr(random_id.address_bytes[i].hex, 3, 2),
      substr(random_id.address_bytes[i].hex, 5, 2),
      substr(random_id.address_bytes[i].hex, 7, 2),
      substr(random_id.address_bytes[i].hex, 9, 2),
    ))
  ]
}
