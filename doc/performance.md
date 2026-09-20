# Performance

Each fixture under `tests/perf/` is compiled by every compiler present on the
machine and run three times; a bar is the median of the three. Shorter is
better in each chart. One run compares compilers on one machine, so the numbers
carry within a chart and not between machines; the per-commit series CI takes
will be published here as it lands.

<div id="perf">Loading <a href="data.json">data.json</a>.</div>

<style>
#perf .run { color: #57606a; font-size: 90%; margin-bottom: 1.5rem; }
#perf .grid { display: grid; gap: 1rem 2rem;
  grid-template-columns: repeat(auto-fit, minmax(19rem, 1fr)); }
#perf .chart { break-inside: avoid; }
#perf .chart h4 { margin: 0 0 .35rem; font-size: 100%; font-family: monospace; }
#perf .bars { display: grid; grid-template-columns: max-content 1fr max-content;
  gap: .2rem .5rem; align-items: center; }
#perf .name { font-size: 85%; white-space: nowrap; }
#perf .track { background: #eaeef2; border-radius: 2px; }
#perf .bar { height: .75rem; border-radius: 2px; background: #8c959f; }
#perf .bar.badc { background: #0969da; }
#perf .val { font-size: 85%; font-variant-numeric: tabular-nums;
  white-space: nowrap; }
@media (prefers-color-scheme: dark) {
  #perf .run { color: #8b949e; }
  #perf .track { background: #21262d; }
  #perf .bar { background: #6e7681; }
  #perf .bar.badc { background: #388bfd; }
}
</style>

<script>
(function () {
  var METRICS = [
    { key: "run_ms", label: "Run time (ms)", scale: 1, digits: 1 },
    { key: "compile_ms", label: "Compile time (ms)", scale: 1, digits: 0 },
    { key: "binary_bytes", label: "Binary size (KiB)", scale: 1024, digits: 1 }
  ];

  function el(tag, cls, text) {
    var n = document.createElement(tag);
    if (cls) n.className = cls;
    if (text !== undefined) n.textContent = text;
    return n;
  }

  function chart(fixture, rows, metric) {
    var box = el("div", "chart");
    box.appendChild(el("h4", null, fixture));
    var bars = el("div", "bars");
    var max = rows.reduce(function (m, r) { return Math.max(m, r.value); }, 0);
    rows.forEach(function (r) {
      bars.appendChild(el("span", "name", r.compiler));
      var track = el("div", "track");
      var bar = el("div", "bar" + (/^badc/.test(r.compiler) ? " badc" : ""));
      bar.style.width = (max > 0 ? (100 * r.value / max) : 0) + "%";
      track.appendChild(bar);
      bars.appendChild(track);
      bars.appendChild(el("span", "val", r.value.toFixed(metric.digits)));
    });
    box.appendChild(bars);
    return box;
  }

  function render(data) {
    var root = document.getElementById("perf");
    root.textContent = "";

    var m = data.machine || {};
    var names = (data.compilers || []).map(function (c) {
      return c.version ? c.name + " (" + c.version + ")" : c.name;
    });
    root.appendChild(el("div", "run",
      [m.cpu, m.system, m.arch].filter(Boolean).join(", ") +
      " · " + data.taken + " · median of " +
      data.runs_per_fixture + " runs · " + names.join("; ")));

    METRICS.forEach(function (metric) {
      root.appendChild(el("h3", null, metric.label));
      var grid = el("div", "grid");
      (data.fixtures || []).forEach(function (fixture) {
        var rows = (data.results || [])
          .filter(function (r) { return r.fixture === fixture; })
          .map(function (r) {
            return { compiler: r.compiler, value: r[metric.key] / metric.scale };
          });
        if (rows.length) grid.appendChild(chart(fixture, rows, metric));
      });
      root.appendChild(grid);
    });
  }

  fetch("data.json").then(function (r) { return r.json(); }).then(render)
    .catch(function (e) {
      document.getElementById("perf").textContent =
        "data.json did not load: " + e;
    });
}());
</script>

The measurements come from `tests/perf/run.py --json`, which compiles each
fixture, runs it three times and records the median wall-clock, the compile
wall-clock and the size of the binary. `tests/perf/*.c` states what each
fixture exercises, and why the shape it takes suits a code generator rather
than an application.
