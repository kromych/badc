use std::fmt;

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

impl std::error::Error for C4Error {}
