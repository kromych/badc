use alloc::string::String;
use core::fmt;

#[derive(Debug, Clone)]
pub enum C5Error {
    Compile(String),
    Runtime(String),
}

impl fmt::Display for C5Error {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            C5Error::Compile(msg) => write!(f, "Compile Error: {}", msg),
            C5Error::Runtime(msg) => write!(f, "Runtime Error: {}", msg),
        }
    }
}

// std::error::Error doesn't exist in core; only register as an Error
// when std is available. Any Display impl is enough for `?` propagation
// either way.
#[cfg(feature = "std")]
impl std::error::Error for C5Error {}
