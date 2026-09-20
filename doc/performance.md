---
title: Performance
---

<!--
The page shows the controls, a block per machine and the charts, and no prose:
what the text below said is kept here, where it is read with the code.

Each fixture under `tests/perf/` is compiled by every compiler present on the
machine and run three times; a bar is the median of the three. Shorter is
better in each chart. A bar carries its measured value and its multiple of
`badc -O` in the same chart, the column `tests/perf/run.py` prints as
`vs badc -O`; a chart that has no `badc -O` row takes its smallest bar as the
reference and marks it `ref`. A chart holds one machine, so the numbers carry
within a chart and not between machines: CI measures the same commit on every
runner and the page draws each of them, with the machine named above its
charts.

A record lists the compilers that ran on its machine, so the set differs by
platform: gcc where gcc exists, a `-march` baseline leg where the compiler
takes one, `cl` on a Windows runner. The page draws what a record carries,
badc first.

The runs live in [badc-perf-data](https://github.com/kromych/badc-perf-data),
keyed by the commit they measured, and this page reads them where they are, so
a new run appears without rebuilding the site.

Two runs compare in place: pick them in the two lists. The selection is the URL
fragment `#a=<sha>/<runner>&b=<sha>/<runner>`, so a comparison can be linked.

The charts are drawn in the browser out of the published JSON, so with
JavaScript off this page carries no numbers of its own; the data repository
serves the runs as files.
-->

<div id="perf"></div>

<noscript>The charts are drawn in the browser from published JSON.</noscript>

<style>
#perf .runs { margin-bottom: 1rem; }
#perf p.run { margin: 0 0 .3rem; }
#perf p.run pre { margin: 0; padding: .4rem .6rem; font-size: 85%;
  line-height: 1.5; background: #f6f8fa; border-radius: 6px;
  white-space: pre-wrap; overflow-wrap: break-word; }
#perf .note { color: #57606a; font-size: 85%; margin: .3rem 0 1rem; }
/* The site's stylesheet leaves a control at the engine's own defaults, which
   is a different widget in each browser; these are the site's own colours. */
#perf .pick { display: flex; flex-wrap: wrap; gap: .4rem .5rem;
  align-items: center; margin: 0 0 1.2rem; }
#perf .pick select, #perf .pick button { font: inherit; font-size: 90%;
  line-height: 1.5; color: #24292f; background: #fff;
  border: 1px solid #d0d7de; border-radius: 6px; padding: .25rem .5rem; }
#perf .pick select { max-width: 24rem; }
#perf .pick button { -webkit-appearance: none; appearance: none;
  background: #f6f8fa; font-weight: 600; cursor: pointer;
  padding: .25rem .75rem; }
#perf .pick button:hover { background: #eef1f4; border-color: #b6bec7; }
#perf .pick button:active { background: #e4e9ee; }
#perf .pick select:focus-visible, #perf .pick button:focus-visible {
  outline: 2px solid #0969da; outline-offset: 1px; }
#perf h4.where { font-size: 90%; margin: 1.2rem 0 .5rem; color: #57606a;
  font-weight: 600; }
#perf .grid { display: grid; gap: 1rem 2rem;
  grid-template-columns: repeat(auto-fit, minmax(19rem, 1fr)); }
#perf .chart { break-inside: avoid; }
#perf .chart h4 { margin: 0 0 .35rem; font-size: 100%; font-family: monospace; }
#perf .bars { display: grid; gap: .2rem .5rem; align-items: center;
  grid-template-columns: max-content 1fr max-content max-content; }
#perf .name { font-size: 85%; white-space: nowrap; }
#perf .track { background: #eaeef2; border-radius: 2px; }
#perf .bar { height: .75rem; border-radius: 2px; background: #8c959f; }
#perf .bar.level { background: #57606a; }
#perf .bar.badc { background: #0969da; }
#perf .val, #perf .ratio { font-size: 85%; white-space: nowrap;
  font-variant-numeric: tabular-nums; }
#perf .ratio { color: #57606a; }
#perf .ratio.ref { color: inherit; }
/* The site's stylesheet gives a markdown table a border, a padding and a
   block display of its own; these are the numbers, not a document table. */
#perf table.cmp { display: table; width: auto; border-collapse: collapse;
  font-size: 85%; margin: 0 0 .4rem; }
#perf table.cmp th, #perf table.cmp td { border: 0; padding: .1rem 1rem .1rem 0;
  text-align: right; font-variant-numeric: tabular-nums; white-space: nowrap; }
#perf table.cmp th { border-bottom: 1px solid #d0d7de; font-weight: 600; }
#perf table.cmp .who { text-align: left; font-family: monospace; }
#perf .dn { color: #1a7f37; }
#perf .up { color: #cf222e; }
#perf .eq { color: #57606a; }
</style>

<script>
(function () {
  // The data repository, read where it lives: raw serves any ref with
  // `access-control-allow-origin: *`, so the site keeps no copy.
  var DATA = "https://raw.githubusercontent.com/kromych/badc-perf-data/main/";
  var CODE = "https://github.com/kromych/badc/blob/";
  var FIXTURES = "tests/perf";
  var REFERENCE = "badc -O";
  var DOT = " \u00b7 ";
  // The index lists every run ever published, and a list of them all costs
  // more to build than the charts do; a picker starts at the newest and is
  // completed when it is opened.
  var SEED = 20;

  var METRICS = [
    { key: "run_ms", label: "Run time (ms)", scale: 1, digits: 1 },
    { key: "compile_ms", label: "Compile time (ms)", scale: 1, digits: 0 },
    { key: "binary_bytes", label: "Binary size (KiB)", scale: 1024, digits: 1 }
  ];

  // Draw order for the compilers of a record, whichever ones it lists: badc
  // first, then the reference compilers, then what a runner adds of its own.
  var FAMILIES = ["badc", "tcc", "clang", "gcc", "cl"];

  function el(tag, cls, text) {
    var n = document.createElement(tag);
    if (cls) n.className = cls;
    if (text !== undefined) n.textContent = text;
    return n;
  }

  function txt(s) { return document.createTextNode(s); }

  function anchor(text, href) {
    var a = el("a", null, text);
    a.href = href;
    return a;
  }

  function num(v) { return typeof v === "number" && isFinite(v); }

  function push(list, x) { if (x && list.indexOf(x) < 0) list.push(x); }

  // A record leaves out what its producer did not know, so every optional
  // field is read through one of these.
  function machine(run) {
    var m = run && run.machine;
    return m && typeof m === "object" ? m : {};
  }

  function runner(entry, run) {
    return machine(run).runner || (entry && entry.runner) || "unknown runner";
  }

  function arch(run) { return machine(run).arch || ""; }

  function short(sha) { return sha ? String(sha).slice(0, 12) : ""; }

  // The page builds links out of a record it does not own, so what goes into
  // a URL is checked to be what it claims.
  function commit(sha) {
    return /^[0-9a-f]{7,40}$/i.test(String(sha)) ? String(sha) : null;
  }

  function web(url) {
    return /^https:\/\//.test(String(url)) ? String(url) : null;
  }

  function when(taken) {
    return taken ? String(taken).slice(0, 16).replace("T", " ") : "";
  }

  function names(run) {
    var out = [];
    ((run && run.compilers) || []).forEach(function (c) {
      if (c) push(out, c.name);
    });
    ((run && run.results) || []).forEach(function (r) {
      if (r) push(out, r.compiler);
    });
    ((run && run.benches) || []).forEach(function (b) {
      if (b) push(out, b.compiler);
    });
    return out;
  }

  function family(name) {
    var i = FAMILIES.indexOf(String(name).split(" ")[0]);
    return i < 0 ? FAMILIES.length : i;
  }

  // One view of the compilers behind the runs on screen: the order their
  // bars take, and what a record says about each of them. `results` may list
  // them in any order and two records need not list the same set, so the
  // order is the page's and not the file's.
  function legsOf(runs) {
    var pos = {}, info = {}, n = 0;
    runs.forEach(function (run) {
      ((run && run.compilers) || []).forEach(function (c) {
        if (!c || !c.name) return;
        if (pos[c.name] === undefined) { pos[c.name] = n; n += 1; }
        if (!info[c.name]) info[c.name] = c;
      });
    });
    function cmp(x, y) {
      var px = pos[x], py = pos[y];
      return family(x) - family(y) ||
        (px === undefined ? 1e6 : px) - (py === undefined ? 1e6 : py) ||
        (x < y ? -1 : x > y ? 1 : 0);
    }
    return {
      cmp: cmp,
      info: function (name) { return info[name] || null; },
      sort: function (list) { return list.slice().sort(cmp); }
    };
  }

  // A run is drawn as a list of corpora: the fixture table first, then one
  // list per `benches` suite. They share the metrics and the compilers, so
  // they share the chart code; only the fixture names carry a link to source.
  function corpora(run) {
    var out = [{ name: FIXTURES, code: true,
                 charts: group(run.fixtures, run.results, "fixture") }];
    var suites = [];
    (run.benches || []).forEach(function (b) { if (b) push(suites, b.suite); });
    suites.forEach(function (s) {
      var rows = (run.benches || []).filter(function (b) {
        return b && b.suite === s;
      });
      out.push({ name: s, code: false, charts: group(null, rows, "name") });
    });
    return out;
  }

  function group(names_, rows, key) {
    var order = [], by = {};
    (names_ || []).forEach(function (n) {
      push(order, n);
      by[n] = by[n] || [];
    });
    (rows || []).forEach(function (r) {
      var n = r && r[key];
      if (!n) return;
      if (!by[n]) { by[n] = []; push(order, n); }
      by[n].push(r);
    });
    return order.map(function (n) {
      return { title: n, records: by[n] || [] };
    });
  }

  function values(charts, metric) {
    var m = {};
    charts.forEach(function (ch) {
      ch.records.forEach(function (r) {
        if (num(r[metric.key])) {
          m[ch.title + "\u0000" + r.compiler] = r[metric.key] / metric.scale;
        }
      });
    });
    return m;
  }

  // The bar labelled against the rest of its chart. `badc -O` is the one the
  // `vs badc -O` column of `tests/perf/run.py` uses; a chart that has no such
  // row takes its smallest bar instead and says which one it took.
  function reference(rows) {
    var named = null, best = null;
    rows.forEach(function (r) {
      if (!named && r.compiler === REFERENCE) named = r;
      if (!best || r.value < best.value) best = r;
    });
    return { row: named || best, named: !!named };
  }

  function chart(title, href, records, metric, legs) {
    var rows = [];
    records.forEach(function (r) {
      if (num(r[metric.key])) {
        rows.push({ compiler: r.compiler || "",
                    value: r[metric.key] / metric.scale });
      }
    });
    if (!rows.length) return null;
    rows.sort(function (p, q) { return legs.cmp(p.compiler, q.compiler); });

    var box = el("div", "chart");
    var head = el("h4");
    head.appendChild(href ? anchor(title, href) : txt(title));
    box.appendChild(head);

    var bars = el("div", "bars");
    var max = rows.reduce(function (m, r) { return Math.max(m, r.value); }, 0);
    var ref = reference(rows);
    var base = ref.row && ref.row.value > 0 ? ref.row.value : 0;
    rows.forEach(function (r) {
      bars.appendChild(el("span", "name", r.compiler));
      var track = el("div", "track");
      var leg = legs.info(r.compiler);
      var bar = el("div", "bar" + (/^badc/.test(r.compiler) ? " badc" : "") +
        (leg && leg.level ? " level" : ""));
      bar.style.width = (max > 0 ? (100 * r.value / max) : 0) + "%";
      track.appendChild(bar);
      bars.appendChild(track);
      bars.appendChild(el("span", "val", r.value.toFixed(metric.digits)));
      var times = base > 0 ? (r.value / base).toFixed(2) + "x" : "\u2014";
      if (r === ref.row) {
        bars.appendChild(el("span", "ratio ref",
          ref.named ? times : times + " ref"));
      } else {
        bars.appendChild(el("span", "ratio", times));
      }
    });
    box.appendChild(bars);
    return box;
  }

  // The toolchain that produced the bars, one line per version a record
  // gives. A record that names no version adds no line: the chart labels
  // already carry the compiler names.
  function toolchain(run, legs) {
    var order = [], by = {}, any = false;
    legs.sort(names(run)).forEach(function (n) {
      var c = legs.info(n), v = (c && c.version) || "";
      if (v) any = true;
      if (!by[v]) { by[v] = []; order.push(v); }
      by[v].push(n);
    });
    if (!any) return [];
    return order.map(function (v) {
      return by[v].join(", ") + (v ? DOT + v : "");
    });
  }

  // One block per machine on screen, so a comparison says on sight which two
  // it holds.
  function runBlock(run, entry, legs, side) {
    var m = machine(run), pre = el("pre"), bits = [];
    if (side) bits.push(side);
    push(bits, [m.arch, m.system].filter(Boolean).join(" "));
    push(bits, runner(entry, run));
    push(bits, m.cpu);
    push(bits, m.image && m.image !== m.runner ? m.image : null);
    push(bits, when(run.taken || (entry && entry.taken)));
    if (num(run.runs_per_fixture)) {
      bits.push("median of " + run.runs_per_fixture + " runs");
    }
    pre.appendChild(txt(bits.join(DOT)));

    var sha = commit((run.commit && run.commit.sha) || (entry && entry.sha));
    if (sha) {
      pre.appendChild(txt(DOT));
      pre.appendChild(anchor(short(sha),
        "https://github.com/kromych/badc/commit/" + sha));
      var branch = (run.commit && run.commit.branch) || (entry && entry.branch);
      if (branch) pre.appendChild(txt(" on " + branch));
    }

    var p = run.provenance || {};
    var source = p.source || (entry && entry.source);
    if (source) {
      pre.appendChild(txt(DOT));
      var what = source === "measured" ? "measured"
        : "recovered from " + source;
      var url = web(p.url);
      pre.appendChild(url ? anchor(what, url) : txt(what));
    }

    toolchain(run, legs).forEach(function (line) {
      pre.appendChild(txt("\n  " + line));
    });
    var box = el("p", "run");
    box.appendChild(pre);
    return box;
  }

  // Every runner of one commit, each with its own chart grids: a bar is only
  // ever scaled against bars measured on the same host.
  function latest(root, shown) {
    var legs = legsOf(shown.map(function (s) { return s.run; }));
    var head = el("div", "runs");
    shown.forEach(function (s) {
      head.appendChild(runBlock(s.run, s.entry, legs));
    });
    root.appendChild(head);

    METRICS.forEach(function (metric) {
      var body = el("div");
      shown.forEach(function (s) {
        var sha = commit((s.run.commit && s.run.commit.sha) ||
          (s.entry && s.entry.sha));
        corpora(s.run).forEach(function (c) {
          var grid = el("div", "grid");
          c.charts.forEach(function (ch) {
            var href = c.code && sha ? CODE + sha + "/" + FIXTURES + "/" +
              encodeURIComponent(ch.title) : null;
            var box = chart(ch.title, href, ch.records, metric, legs);
            if (box) grid.appendChild(box);
          });
          if (!grid.children.length) return;
          body.appendChild(el("h4", "where",
            [arch(s.run), runner(s.entry, s.run), c.name]
              .filter(Boolean).join(DOT)));
          body.appendChild(grid);
        });
      });
      // A run that carries none of a metric -- the compile time of a run
      // recovered from a job log -- gets no heading.
      if (body.children.length) {
        root.appendChild(el("h3", null, metric.label));
        root.appendChild(body);
      }
    });
  }

  // B as a multiple of A, the form the charts use. The band is what two
  // decimals resolve: a value that prints 1.00x is not a change.
  var LOW = 0.995, HIGH = 1.005;

  function times(x) { return x.toFixed(2) + "x"; }

  function change(a, b) {
    var cell = el("td");
    if (!num(a) || !num(b) || a === 0) {
      cell.appendChild(el("span", "eq", "\u2014"));
      return cell;
    }
    var x = b / a;
    var cls = x < LOW ? "dn" : (x > HIGH ? "up" : "eq");
    var mark = x < LOW ? "\u2193 " : (x > HIGH ? "\u2191 " : "= ");
    cell.appendChild(el("span", cls, mark + times(x)));
    return cell;
  }

  function median(xs) {
    var s = xs.slice().sort(function (x, y) { return x - y; }), n = s.length;
    if (!n) return null;
    return n % 2 ? s[(n - 1) / 2] : (s[n / 2 - 1] + s[n / 2]) / 2;
  }

  function table(ca, cb, metric, who, what) {
    var va = values(ca ? ca.charts : [], metric);
    var vb = values(cb ? cb.charts : [], metric);
    var titles = [], ratios = [], lower = 0, higher = 0;
    (ca ? ca.charts : []).forEach(function (ch) { push(titles, ch.title); });
    (cb ? cb.charts : []).forEach(function (ch) { push(titles, ch.title); });

    var body = el("tbody");
    titles.forEach(function (title) {
      who.forEach(function (compiler) {
        var k = title + "\u0000" + compiler;
        var a = va[k], b = vb[k];
        if (!num(a) && !num(b)) return;
        var row = el("tr");
        row.appendChild(el("td", "who", title));
        row.appendChild(el("td", "who", compiler));
        row.appendChild(el("td", null,
          num(a) ? a.toFixed(metric.digits) : "\u2014"));
        row.appendChild(el("td", null,
          num(b) ? b.toFixed(metric.digits) : "\u2014"));
        row.appendChild(change(a, b));
        body.appendChild(row);
        if (num(a) && num(b) && a !== 0) {
          var x = b / a;
          ratios.push(x);
          if (x < LOW) lower += 1; else if (x > HIGH) higher += 1;
        }
      });
    });
    if (!body.children.length) return null;

    var node = el("table", "cmp");
    var head = el("tr");
    [what, "compiler", "A", "B", "change"].forEach(function (h, i) {
      head.appendChild(el("th", i < 2 ? "who" : null, h));
    });
    var header = el("thead");
    header.appendChild(head);
    node.appendChild(header);
    node.appendChild(body);

    var m = median(ratios);
    var note = el("div", "note", body.children.length + " rows" + DOT +
      lower + " lower" + DOT + higher + " higher" +
      (m === null ? "" : DOT + "median " + times(m)));
    return { node: node, note: note };
  }

  function compare(root, a, b) {
    var legs = legsOf([a.run, b.run]);
    var head = el("div", "runs");
    head.appendChild(runBlock(a.run, a.entry, legs, "A"));
    head.appendChild(runBlock(b.run, b.entry, legs, "B"));
    root.appendChild(head);

    var who = legs.sort(names(a.run).concat(names(b.run)).filter(
      function (n, i, all) { return all.indexOf(n) === i; }));

    METRICS.forEach(function (metric) {
      var body = el("div"), suites = [];
      var ca = corpora(a.run), cb = corpora(b.run);
      ca.concat(cb).forEach(function (c) { push(suites, c.name); });
      suites.forEach(function (name) {
        function pick(list) {
          return list.filter(function (c) {
            return c.name === name;
          })[0] || null;
        }
        var c = pick(ca) || pick(cb);
        var t = table(pick(ca), pick(cb), metric, who,
          c && c.code ? "fixture" : "bench");
        if (!t) return;
        body.appendChild(el("h4", "where", name));
        body.appendChild(t.node);
        body.appendChild(t.note);
      });
      if (body.children.length) {
        root.appendChild(el("h3", null, metric.label));
        root.appendChild(body);
      }
    });
  }

  function key(entry) { return short(entry.sha) + "/" + (entry.runner || ""); }

  function label(entry) {
    return [when(entry.taken), short(entry.sha), entry.runner, entry.branch]
      .filter(Boolean).join(DOT);
  }

  // A selection names a commit and a runner; the sha may be any prefix, so a
  // hand-written link keeps working when it is shortened.
  function resolve(entries, spec) {
    if (!spec) return null;
    var parts = String(spec).split("/");
    var sha = (parts[0] || "").toLowerCase(), want = parts[1] || "";
    var hit = null;
    entries.forEach(function (e) {
      if (hit || !e.sha) return;
      if (String(e.sha).toLowerCase().indexOf(sha) !== 0) return;
      if (want && (e.runner || "") !== want) return;
      hit = e;
    });
    return hit;
  }

  function selection() {
    var params = {}, h = String(window.location.hash || "").replace(/^#/, "");
    h.split("&").forEach(function (kv) {
      var i = kv.indexOf("=");
      if (i > 0) {
        params[decodeURIComponent(kv.slice(0, i))] =
          decodeURIComponent(kv.slice(i + 1));
      }
    });
    // A fragment that names neither run is someone else's -- the theme links
    // its headings through it as well.
    return { params: params, mine: !h || h === "latest" ||
      params.a !== undefined || params.b !== undefined };
  }

  function option(entry) {
    var opt = el("option", null, label(entry));
    opt.value = key(entry);
    return opt;
  }

  // The newest runs, and the selected one wherever it sits; the rest of the
  // index is built into the list the first time it is opened.
  function chooser(side, entries, current) {
    var sel = el("select"), seed = [], i;
    sel.setAttribute("aria-label", "run " + side);
    for (i = 0; i < SEED && i < entries.length; i += 1) seed.push(entries[i]);
    if (current && seed.indexOf(current) < 0) seed.push(current);
    seed.forEach(function (e) { sel.appendChild(option(e)); });
    if (current) sel.value = key(current);

    var full = seed.length === entries.length;
    function fill() {
      if (full) return;
      full = true;
      var value = sel.value, all = document.createDocumentFragment();
      entries.forEach(function (e) { all.appendChild(option(e)); });
      sel.textContent = "";
      sel.appendChild(all);
      sel.value = value;
    }
    ["focus", "pointerdown", "keydown"].forEach(function (type) {
      sel.addEventListener(type, fill);
    });
    return sel;
  }

  function picker(entries, a, b) {
    var box = el("div", "pick");
    var left = chooser("A", entries, a), right = chooser("B", entries, b);
    box.appendChild(left);
    box.appendChild(right);

    var go = el("button", null, "Show the change");
    go.type = "button";
    go.addEventListener("click", function () {
      // The separator is a fragment character of its own: escaping it would
      // only make the link harder to read and to write by hand.
      function part(v) {
        return String(v).split("/").map(encodeURIComponent).join("/");
      }
      window.location.hash = "a=" + part(left.value) +
        "&b=" + part(right.value);
    });
    box.appendChild(go);

    var now = el("button", null, "Latest runs");
    now.type = "button";
    now.addEventListener("click", function () {
      window.location.hash = "latest";
    });
    box.appendChild(now);
    return box;
  }

  var pending = {}, shown = null;

  function get(path) {
    if (!pending[path]) {
      pending[path] = fetch(DATA + path).then(function (r) {
        if (!r.ok) throw new Error(path + ": " + r.status);
        return r.json();
      });
    }
    return pending[path];
  }

  function fail(what) {
    var root = document.getElementById("perf");
    if (root) root.textContent = what;
    shown = null;
  }

  function newest(entries) {
    return entries.slice().sort(function (x, y) {
      return String(y.taken || "").localeCompare(String(x.taken || ""));
    });
  }

  // Every runner of the newest commit, rather than whichever finished last.
  function newestRun(entries) {
    var sha = entries[0].sha, seen = {}, pick = [];
    entries.forEach(function (e) {
      var r = e.runner || "";
      if (e.sha === sha && !seen[r]) { seen[r] = 1; pick.push(e); }
    });
    return pick.sort(function (x, y) {
      return String(x.runner || "").localeCompare(String(y.runner || ""));
    });
  }

  function draw(entries) {
    var sel = selection();
    if (!sel.mine && shown !== null) return Promise.resolve();
    var a = resolve(entries, sel.params.a), b = resolve(entries, sel.params.b);

    // Only a change of selection redraws.
    var want = a && b ? key(a) + DOT + key(b) : "latest";
    if (want === shown) return Promise.resolve();
    shown = want;

    // The run files are asked for before anything is built, so the fetch and
    // the controls overlap rather than queue.
    var pick = a && b ? [a, b] : newestRun(entries);
    var loading = Promise.all(pick.map(function (e) { return get(e.path); }));

    var root = document.getElementById("perf");
    root.textContent = "";
    // The default pair the picker offers: the newest run against the one
    // before it on the same runner.
    var same = entries.filter(function (e) {
      return (e.runner || "") === (entries[0].runner || "");
    });
    root.appendChild(picker(entries, a || same[1] || entries[1] || entries[0],
      b || same[0] || entries[0]));

    return loading.then(function (runs) {
      var got = pick.map(function (e, i) {
        return { entry: e, run: runs[i] };
      });
      if (a && b) compare(root, got[0], got[1]); else latest(root, got);
    });
  }

  get("index.json").then(function (index) {
    var entries = newest((index && index.runs) || []);
    if (!entries.length) return fail("No runs published yet.");
    window.addEventListener("hashchange", function () {
      draw(entries).catch(function (e) {
        fail("that run did not load: " + e);
      });
    });
    return draw(entries);
  }).catch(function (e) { fail("the published runs did not load: " + e); });
}());
</script>

<!--
The measurements come from the JSON mode of `tests/perf/run.py`, which
compiles each fixture, runs it three times and records the median
wall-clock, the compile wall-clock and the size of the binary; the
`benches` section beside it holds
what the demo comparisons measure, CPython first. `scripts/perf_publish.py`
files a run under `runs/<sha[0:2]>/<sha[2:4]>/<sha>/<runner>.json` in the data
repository, points `branches/<name>` at it and adds it to `index.json`.
`tests/perf/*.c` states what each fixture exercises, and why the shape it takes
suits a code generator rather than an application.
-->
