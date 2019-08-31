// Do not use or link to standard library. 
// 
// https://doc.rust-lang.org/1.30.0/book/first-edition/using-rust-without-the-standard-library.html
//
#![no_std]

#![no_main]

use core::panic::PanicInfo;

#[no_mangle]
pub extern "C" fn _start() -> ! {
    loop {}
}

/// This function is called on panic.
//
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
