/// Per-phase wall clock for the native link, reported to stderr when
/// `BADC_LINK_STATS` is set. Off by default: `mark` is a load and a
/// branch, so an unset environment pays nothing measurable.
pub(crate) struct LinkStats {
    on: bool,
    marks: Vec<(&'static str, core::time::Duration)>,
    last: std::time::Instant,
}

impl LinkStats {
    pub(crate) fn new() -> Self {
        Self {
            on: std::env::var_os("BADC_LINK_STATS").is_some(),
            marks: Vec::new(),
            last: std::time::Instant::now(),
        }
    }

    /// Close the phase that ended here and name it.
    pub(crate) fn mark(&mut self, phase: &'static str) {
        if !self.on {
            return;
        }
        let now = std::time::Instant::now();
        self.marks.push((phase, now - self.last));
        self.last = now;
    }

    pub(crate) fn report(&self, inputs: usize) {
        if !self.on {
            return;
        }
        let mut line = format!("badc: link stats: inputs={inputs}");
        let mut total = 0.0;
        for (phase, d) in &self.marks {
            let ms = d.as_secs_f64() * 1e3;
            total += ms;
            line.push_str(&format!(" {phase}={ms:.0}ms"));
        }
        eprintln!("{line} total={total:.0}ms");
    }
}
