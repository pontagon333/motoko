//! Defines mutator allocation interface

use crate::page_alloc::ic::IcPageAlloc;
use crate::space::Space;
use crate::types::{Value, Words};

// TODO: We should use `MaybeUninit` here, but `MaybeUninit::assume_init_ref` does not exist in the
// Rust version we're using.. Need to update rustc.
pub static mut ALLOCATION_SPACE: Option<Space<IcPageAlloc>> = None;

pub unsafe fn init() {
    ALLOCATION_SPACE = Some(Space::new(IcPageAlloc {}));
}

#[no_mangle]
pub unsafe fn alloc_words(n: Words<u32>) -> Value {
    ALLOCATION_SPACE.as_mut().unwrap().alloc_words(n)
}

pub unsafe fn free_and_update_allocation_space(new: Space<IcPageAlloc>) {
    let mut old = ALLOCATION_SPACE.replace(new).unwrap();
    old.free();
}