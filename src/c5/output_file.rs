//! Writing an output file. A regular file at the output path is replaced,
//! not rewritten: the bytes go to a new file in the same directory, which
//! is renamed over the path, as lld does. Rewriting in place fails when the
//! old file is a running executable (ETXTBSY on Linux) or is mapped by
//! another process (ERROR_USER_MAPPED_FILE on Windows); a rename leaves the
//! old file to its users. Any other kind of file at the path -- a device, a
//! FIFO, a symlink -- is written through, as GNU ld does: `-o /dev/null`.

use std::fs::{File, OpenOptions};
use std::io::{self, Write};
use std::path::{Path, PathBuf};

/// Write `bytes` to `path`. An `executable` output is created with every
/// execute bit the umask allows, as a linker's output is.
pub fn write_output_file(path: &Path, bytes: &[u8], executable: bool) -> io::Result<()> {
    if let Ok(md) = std::fs::symlink_metadata(path)
        && !md.file_type().is_file()
    {
        return std::fs::write(path, bytes);
    }
    let (tmp, mut file) = match create_sibling(path, executable) {
        Ok(v) => v,
        // A directory that takes no new entry can still hold a writable file.
        Err(e) if e.kind() == io::ErrorKind::PermissionDenied => {
            return write_in_place(path, bytes, executable);
        }
        Err(e) => return Err(e),
    };
    let res = file.write_all(bytes);
    drop(file);
    if let Err(e) = res.and_then(|()| std::fs::rename(&tmp, path)) {
        let _ = std::fs::remove_file(&tmp);
        return Err(e);
    }
    Ok(())
}

/// Create a file next to `path` under a name no other file has.
fn create_sibling(path: &Path, executable: bool) -> io::Result<(PathBuf, File)> {
    let Some(name) = path.file_name() else {
        return Err(io::Error::new(
            io::ErrorKind::InvalidInput,
            "the output path names no file",
        ));
    };
    let dir = match path.parent() {
        Some(d) if !d.as_os_str().is_empty() => d,
        _ => Path::new("."),
    };
    let mut opts = OpenOptions::new();
    opts.write(true).create_new(true);
    #[cfg(unix)]
    std::os::unix::fs::OpenOptionsExt::mode(&mut opts, if executable { 0o777 } else { 0o666 });
    #[cfg(not(unix))]
    let _ = executable;
    let mut n = 0u32;
    loop {
        let mut tmp_name = name.to_os_string();
        tmp_name.push(alloc::format!(".tmp{}-{n}", std::process::id()));
        let tmp = dir.join(tmp_name);
        match opts.open(&tmp) {
            Ok(f) => return Ok((tmp, f)),
            Err(e) if e.kind() == io::ErrorKind::AlreadyExists && n < 64 => n += 1,
            Err(e) => return Err(e),
        }
    }
}

fn write_in_place(path: &Path, bytes: &[u8], executable: bool) -> io::Result<()> {
    std::fs::write(path, bytes)?;
    #[cfg(unix)]
    if executable {
        use std::os::unix::fs::PermissionsExt;
        let mut perms = std::fs::metadata(path)?.permissions();
        perms.set_mode(perms.mode() | 0o111);
        std::fs::set_permissions(path, perms)?;
    }
    #[cfg(not(unix))]
    let _ = executable;
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::write_output_file;

    fn scratch(name: &str) -> std::path::PathBuf {
        let d =
            std::env::temp_dir().join(alloc::format!("badc-output-{name}-{}", std::process::id()));
        let _ = std::fs::remove_dir_all(&d);
        std::fs::create_dir_all(&d).unwrap();
        d
    }

    #[test]
    fn a_regular_file_is_replaced_and_no_temporary_stays() {
        let d = scratch("replace");
        let p = d.join("out");
        std::fs::write(&p, b"old contents").unwrap();
        write_output_file(&p, b"new", false).unwrap();
        assert_eq!(std::fs::read(&p).unwrap(), b"new");
        let names: alloc::vec::Vec<_> = std::fs::read_dir(&d)
            .unwrap()
            .map(|e| e.unwrap().file_name())
            .collect();
        assert_eq!(names, [std::ffi::OsString::from("out")]);
        let _ = std::fs::remove_dir_all(&d);
    }

    // The old file stays whole for a reader that has it open.
    #[test]
    fn an_open_file_keeps_its_contents_for_its_reader() {
        use std::io::Read;
        let d = scratch("open");
        let p = d.join("out");
        std::fs::write(&p, b"old").unwrap();
        let mut held = std::fs::File::open(&p).unwrap();
        write_output_file(&p, b"new", true).unwrap();
        let mut s = alloc::vec::Vec::new();
        held.read_to_end(&mut s).unwrap();
        assert_eq!(s, b"old");
        assert_eq!(std::fs::read(&p).unwrap(), b"new");
        drop(held);
        let _ = std::fs::remove_dir_all(&d);
    }

    #[cfg(unix)]
    #[test]
    fn an_executable_output_takes_execute_bits_and_a_device_is_written_through() {
        use std::os::unix::fs::PermissionsExt;
        let d = scratch("mode");
        let p = d.join("exe");
        write_output_file(&p, b"x", true).unwrap();
        assert_ne!(
            std::fs::metadata(&p).unwrap().permissions().mode() & 0o100,
            0
        );
        let o = d.join("obj");
        write_output_file(&o, b"x", false).unwrap();
        assert_eq!(
            std::fs::metadata(&o).unwrap().permissions().mode() & 0o111,
            0
        );
        let null = std::path::Path::new("/dev/null");
        let before = std::fs::metadata(null).unwrap().permissions().mode();
        write_output_file(null, b"x", true).unwrap();
        assert_eq!(
            std::fs::metadata(null).unwrap().permissions().mode(),
            before
        );
        assert!(!std::fs::metadata(null).unwrap().is_file());
        let _ = std::fs::remove_dir_all(&d);
    }
}
