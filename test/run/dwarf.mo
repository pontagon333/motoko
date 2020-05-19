// RUN: llvm-dwarfdump %.wasm -all --verbose | FileCheck %.mo -check-prefix=DWARF

// DWARF: dwarf.wasm: file format WASM

// DWARF: .debug_abbrev contents:
// DWARF-NEXT: Abbrev table for offset: 0x00000000
// DWARF-NEXT: [1] DW_TAG_compile_unit DW_CHILDREN_yes
// DWARF-NEXT:         DW_AT_producer  DW_FORM_strp
// DWARF-NEXT:         DW_AT_language  DW_FORM_data2
// DWARF-NEXT:         DW_AT_name      DW_FORM_strp
// DWARF-NEXT:         DW_AT_stmt_list DW_FORM_sec_offset
// DWARF-NEXT:         DW_AT_comp_dir  DW_FORM_strp
// DWARF-NEXT:         DW_AT_low_pc    DW_FORM_addr
// DWARF-NEXT:         DW_AT_high_pc   DW_FORM_data4

import Prim "mo:prim"

assert (1 == 1);
// DWARF-LABEL: .debug_info contents:
// DWARF:          : DW_TAG_compile_unit [1] *
// DWARF-NEXT:         DW_AT_producer [DW_FORM_strp] {{.*}} "DFINITY Motoko compiler, version 0.1"
// DWARF-NEXT:         DW_AT_language [DW_FORM_data2] (DW_LANG_Swift)
// DWARF-NEXT:         DW_AT_name     [DW_FORM_strp] {{.*}} "motoko.mo"
// DWARF-NEXT:         DW_AT_comp_dir [DW_FORM_strp]
// DWARF-NEXT:         DW_AT_low_pc   [DW_FORM_addr]
// DWARF-NEXT:         DW_AT_high_pc  [DW_FORM_data4]
// DWARF-NEXT:         DW_AT_high_pc   DW_FORM_data4
// DWARF:           NULL

func foo (a : Int) : Bool {
  return a == 42
};

// DWARF:          : DW_TAG_subprogram [2] *
// DWARF-LABEL:        DW_AT_name     [DW_FORM_strp] {{.*}} "foo"
// DWARF-NEXT:         DW_AT_decl_line [DW_FORM_data1]        (29)
// DWARF-NEXT:         DW_AT_decl_column [DW_FORM_data1]      (0x00)

// DWARF:          :   DW_TAG_formal_parameter [3]
// DWARF-NEXT:           DW_AT_name     [DW_FORM_strp] {{.*}} "a"
// DWARF-NEXT:           DW_AT_decl_line [DW_FORM_data1]        (29)
// DWARF-NEXT:           DW_AT_decl_column [DW_FORM_data1]      (0x0a)

// DWARF:          NULL
// DWARF:        NULL

func baz (a : Int) : Bool = a == 42;

func bar (a : Int) : Int {
    let b = a + 42;

    if (foo b) { b } else { ignore b; assert (a != 42); b }
}