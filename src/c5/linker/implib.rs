//! The import library of a DLL, as link.exe writes one beside a DLL it
//! links (`/IMPLIB`) and GNU ld under `--out-implib`: an archive of the
//! PE/COFF specification's short import members, one per export, whose
//! symbol index names `__imp_<name>` for each and `<name>` for a function.
//! A data export has no thunk, so its bare name is not defined.

use alloc::string::String;
use alloc::vec::Vec;

use super::archive::{ArchiveMember, write_archive};
use super::object::{NativeMachine, SharedLibrary};

const IMAGE_FILE_MACHINE_AMD64: u16 = 0x8664;
const IMAGE_FILE_MACHINE_ARM64: u16 = 0xaa64;
const IMPORT_OBJECT_CODE: u16 = 0;
const IMPORT_OBJECT_DATA: u16 = 1;
/// The import is by the ordinal in the header's Ordinal/Hint field.
const IMPORT_OBJECT_ORDINAL: u16 = 0;
/// The import name is the public symbol's name.
const IMPORT_OBJECT_NAME: u16 = 1;

/// The import library for `lib`, a DLL the link wrote: its exports in name
/// order, each data where the DLL's export reads as data, and one in
/// `export_ordinals` imported by that ordinal.
pub fn write_import_library(lib: &SharedLibrary) -> Vec<u8> {
    let machine = match lib.machine {
        NativeMachine::X86_64 => IMAGE_FILE_MACHINE_AMD64,
        NativeMachine::Aarch64 => IMAGE_FILE_MACHINE_ARM64,
    };
    let names: Vec<&String> = (lib.exports.iter())
        .filter(|n| !n.starts_with("__imp_"))
        .collect();
    let mut members = Vec::with_capacity(names.len());
    let mut symbols = Vec::with_capacity(names.len());
    let mut hint = 0u16;
    for name in names {
        let data = lib.data_exports.contains(name);
        // The hint indexes the DLL's name table, which an ordinal import
        // has no entry in.
        let (by, slot) = match lib.export_ordinals.get(name) {
            Some(&ordinal) => (IMPORT_OBJECT_ORDINAL, ordinal),
            None => {
                hint += 1;
                (IMPORT_OBJECT_NAME, hint - 1)
            }
        };
        let kind = if data {
            IMPORT_OBJECT_DATA
        } else {
            IMPORT_OBJECT_CODE
        };
        let strings = [name.as_bytes(), b"\0", lib.soname.as_bytes(), b"\0"].concat();
        let mut bytes = Vec::with_capacity(20 + strings.len());
        bytes.extend(0u16.to_le_bytes());
        bytes.extend(0xffffu16.to_le_bytes());
        bytes.extend(0u16.to_le_bytes());
        bytes.extend(machine.to_le_bytes());
        bytes.extend(0u32.to_le_bytes());
        bytes.extend((strings.len() as u32).to_le_bytes());
        bytes.extend(slot.to_le_bytes());
        bytes.extend((kind | by << 2).to_le_bytes());
        bytes.extend(strings);
        let mut defined = alloc::vec![alloc::format!("__imp_{name}")];
        if !data {
            defined.push(name.clone());
        }
        symbols.push((members.len(), defined));
        members.push(ArchiveMember {
            name: lib.soname.clone(),
            bytes,
        });
    }
    write_archive(&members, &symbols)
}
