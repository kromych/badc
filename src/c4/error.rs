use alloc::string::String;
use core::fmt;

#[derive(Debug, Clone)]
pub enum C4Error {
    Compile(String),
    Runtime(String),
}

impl fmt::Display for C4Error {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            C4Error::Compile(msg) => write!(f, "Compile Error: {}", msg),
            C4Error::Runtime(msg) => write!(f, "Runtime Error: {}", msg),
        }
    }
}

// std::error::Error doesn't exist in core; only register as an Error
// when std is available. Any Display impl is enough for `?` propagation
// either way.
#[cfg(feature = "std")]
impl std::error::Error for C4Error {}
