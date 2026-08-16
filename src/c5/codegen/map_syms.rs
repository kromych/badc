//! AArch64 mapping symbols.
//!
//! The ELF for the Arm 64-bit Architecture requires a section that holds
//! A64 code to say where the code is: `$x` names the start of a run of
//! instructions, `$d` the start of a run of data, and a run reaches to the
//! next mapping symbol or to the end of the section. (`$a` and `$t` are
//! AArch32 states and never appear in an AArch64 object.)
//!
//! Both producers record what they lay down as [`MapMark`]s -- the
//! assembler as it materializes section items, the backend as it fills the
//! text stream -- and the ELF writer folds a section's marks into run
//! starts in one place.

/// What a run of bytes holds.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum MapClass {
    Code,
    Data,
}

impl MapClass {
    /// The name the ABI gives a run of this kind.
    pub(crate) fn symbol_name(self) -> &'static str {
        match self {
            MapClass::Code => "$x",
            MapClass::Data => "$d",
        }
    }
}

/// One recorded range of a section's bytes.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) struct MapMark {
    pub at: u32,
    pub len: u32,
    pub class: MapClass,
    /// Opens a run whether or not the range has bytes. Alignment padding
    /// does: the directive fixes the class of the bytes it would write
    /// even where it writes none, and GNU as records that.
    pub opens: bool,
}

/// Ranges recorded as a section's bytes are laid down, in the order the
/// producer wrote them.
#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub(crate) struct MapMarks(alloc::vec::Vec<MapMark>);

impl MapMarks {
    /// Record `len` bytes of `class` at `at`.
    pub(crate) fn content(&mut self, at: usize, len: usize, class: MapClass) {
        if len > 0 {
            self.push(at, len, class, false);
        }
    }

    /// Record alignment padding of `class` at `at`.
    pub(crate) fn align(&mut self, at: usize, class: MapClass) {
        self.push(at, 0, class, true);
    }

    fn push(&mut self, at: usize, len: usize, class: MapClass, opens: bool) {
        self.0.push(MapMark {
            at: at as u32,
            len: len as u32,
            class,
            opens,
        });
    }

    /// Drop the record back to a section length of `len`, for a producer
    /// that rolled its bytes back.
    pub(crate) fn truncate(&mut self, len: usize) {
        self.0.retain(|m| (m.at as usize) < len);
    }

    /// The marks shifted by `base`, for a payload placed inside a larger
    /// section.
    pub(crate) fn shifted(&self, base: u32) -> impl Iterator<Item = MapMark> + '_ {
        self.0.iter().map(move |m| MapMark {
            at: m.at + base,
            ..*m
        })
    }
}

/// The marks of a code stream `len` bytes long whose only data are
/// `ranges`, each `(offset, len)`, in ascending order.
pub(crate) fn code_stream_marks(len: usize, ranges: &[(usize, usize)]) -> alloc::vec::Vec<MapMark> {
    let mut marks = MapMarks::default();
    let mut at = 0usize;
    for &(start, n) in ranges {
        if start < at || start.saturating_add(n) > len {
            continue;
        }
        marks.content(at, start - at, MapClass::Code);
        marks.content(start, n, MapClass::Data);
        at = start + n;
    }
    marks.content(at, len.saturating_sub(at), MapClass::Code);
    marks.0
}

/// Fold a section's marks into the offsets its mapping symbols sit at.
///
/// A run opens where the class changes. An executable section's leading
/// data opens a run at once -- a disassembler decodes those bytes as
/// instructions without a `$d`. Where `exec` is false nothing needs
/// disambiguating, so a leading data run is held until instructions or an
/// opening mark appear, and then starts at the offset the data did. A
/// start on the offset of the previous start replaces it, and a start on
/// the section's end marks no bytes and is dropped.
pub(crate) fn fold(
    marks: &mut [MapMark],
    len: usize,
    exec: bool,
) -> alloc::vec::Vec<(u32, MapClass)> {
    marks.sort_by_key(|m| (m.at, !m.opens));
    let mut starts: alloc::vec::Vec<(u32, MapClass)> = alloc::vec::Vec::new();
    let mut state: Option<MapClass> = None;
    let mut held_data: Option<u32> = None;
    let open = |starts: &mut alloc::vec::Vec<(u32, MapClass)>,
                state: &mut Option<MapClass>,
                at: u32,
                class: MapClass| {
        if *state == Some(class) {
            return;
        }
        if starts.last().is_some_and(|&(o, _)| o == at) {
            starts.pop();
        }
        starts.push((at, class));
        *state = Some(class);
    };
    for m in marks.iter() {
        match m.class {
            MapClass::Data if !m.opens && !exec && state.is_none() => {
                held_data.get_or_insert(m.at);
            }
            MapClass::Data => {
                // A held run is already open here, so the mark that forces
                // it out keeps the offset the data started at.
                if let Some(held) = held_data.take() {
                    open(&mut starts, &mut state, held, MapClass::Data);
                }
                open(&mut starts, &mut state, m.at, m.class);
            }
            MapClass::Code => {
                if let Some(held) = held_data.take() {
                    open(&mut starts, &mut state, held, MapClass::Data);
                }
                open(&mut starts, &mut state, m.at, m.class);
            }
        }
    }
    starts.retain(|&(o, _)| (o as usize) < len);
    starts
}

#[cfg(test)]
mod tests {
    use super::*;

    fn run(marks: &mut [MapMark], len: usize) -> alloc::vec::Vec<(u32, &'static str)> {
        run_in(marks, len, false)
    }

    fn run_in(
        marks: &mut [MapMark],
        len: usize,
        exec: bool,
    ) -> alloc::vec::Vec<(u32, &'static str)> {
        fold(marks, len, exec)
            .into_iter()
            .map(|(o, c)| (o, c.symbol_name()))
            .collect()
    }

    fn marks() -> MapMarks {
        MapMarks::default()
    }

    #[test]
    fn code_then_data_then_code_opens_three_runs() {
        let mut m = marks();
        m.content(0, 8, MapClass::Code);
        m.content(8, 8, MapClass::Data);
        m.content(16, 8, MapClass::Code);
        assert_eq!(run(&mut m.0, 24), [(0, "$x"), (8, "$d"), (16, "$x")]);
    }

    #[test]
    fn data_only_section_carries_no_runs() {
        let mut m = marks();
        m.content(0, 4, MapClass::Data);
        assert_eq!(run(&mut m.0, 4), []);
    }

    #[test]
    fn data_only_executable_section_opens_a_data_run() {
        let mut m = marks();
        m.content(0, 4, MapClass::Data);
        assert_eq!(run_in(&mut m.0, 4, true), [(0, "$d")]);
    }

    #[test]
    fn an_empty_executable_section_carries_no_runs() {
        assert_eq!(run_in(&mut [], 0, true), []);
    }

    #[test]
    fn executable_leading_data_opens_where_the_data_starts() {
        let mut m = marks();
        m.content(8, 4, MapClass::Data);
        m.content(12, 4, MapClass::Code);
        assert_eq!(run_in(&mut m.0, 16, true), [(8, "$d"), (12, "$x")]);
    }

    #[test]
    fn leading_data_opens_at_zero_once_code_appears() {
        let mut m = marks();
        m.content(0, 4, MapClass::Data);
        m.content(4, 4, MapClass::Code);
        assert_eq!(run(&mut m.0, 8), [(0, "$d"), (4, "$x")]);
    }

    #[test]
    fn empty_padding_start_is_superseded_by_the_next_run() {
        let mut m = marks();
        m.content(0, 8, MapClass::Code);
        m.align(8, MapClass::Data);
        m.content(8, 4, MapClass::Code);
        assert_eq!(run(&mut m.0, 12), [(0, "$x"), (8, "$x")]);
    }

    #[test]
    fn code_padding_extends_the_run_it_follows() {
        let mut m = marks();
        m.content(0, 4, MapClass::Code);
        m.align(4, MapClass::Code);
        m.content(16, 4, MapClass::Code);
        assert_eq!(run(&mut m.0, 20), [(0, "$x")]);
    }

    #[test]
    fn padding_opens_a_data_run_in_a_data_only_section() {
        let mut m = marks();
        m.align(0, MapClass::Data);
        m.content(0, 4, MapClass::Data);
        assert_eq!(run(&mut m.0, 4), [(0, "$d")]);
    }

    #[test]
    fn padding_after_leading_data_keeps_the_run_start() {
        let mut m = marks();
        m.content(0, 1, MapClass::Data);
        m.align(1, MapClass::Data);
        m.align(4, MapClass::Code);
        m.content(4, 4, MapClass::Code);
        assert_eq!(run(&mut m.0, 8), [(0, "$d"), (4, "$x")]);
    }

    #[test]
    fn a_start_on_the_section_end_is_dropped() {
        let mut m = marks();
        m.content(0, 4, MapClass::Code);
        m.align(4, MapClass::Data);
        assert_eq!(run(&mut m.0, 4), [(0, "$x")]);
    }

    #[test]
    fn an_empty_section_carries_no_runs() {
        assert_eq!(run(&mut code_stream_marks(0, &[]), 0), []);
    }

    #[test]
    fn a_code_stream_marks_its_embedded_data() {
        assert_eq!(
            run(&mut code_stream_marks(64, &[(16, 20)]), 64),
            [(0, "$x"), (16, "$d"), (36, "$x")]
        );
    }

    #[test]
    fn a_code_stream_ending_in_data_opens_no_trailing_run() {
        assert_eq!(
            run(&mut code_stream_marks(32, &[(16, 16)]), 32),
            [(0, "$x"), (16, "$d")]
        );
    }

    #[test]
    fn marks_out_of_order_fold_the_same() {
        let mut m = marks();
        m.content(16, 8, MapClass::Code);
        m.content(0, 8, MapClass::Code);
        m.content(8, 8, MapClass::Data);
        assert_eq!(run(&mut m.0, 24), [(0, "$x"), (8, "$d"), (16, "$x")]);
    }

    #[test]
    fn a_shifted_payload_keeps_its_own_runs() {
        let mut inner = marks();
        inner.content(0, 4, MapClass::Code);
        inner.align(4, MapClass::Data);
        inner.content(4, 4, MapClass::Code);
        let mut m: alloc::vec::Vec<MapMark> = inner.shifted(16).collect();
        m.push(MapMark {
            at: 0,
            len: 16,
            class: MapClass::Data,
            opens: true,
        });
        assert_eq!(run(&mut m, 24), [(0, "$d"), (16, "$x"), (20, "$x")]);
    }

    #[test]
    fn truncation_drops_the_marks_it_removes() {
        let mut m = marks();
        m.content(0, 8, MapClass::Code);
        m.content(8, 8, MapClass::Data);
        m.truncate(8);
        m.content(8, 4, MapClass::Code);
        assert_eq!(run(&mut m.0, 12), [(0, "$x")]);
    }
}
