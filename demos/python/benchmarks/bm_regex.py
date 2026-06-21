# Regular-expression search over a fixed corpus (the _sre engine). Output
# is the total match count across all patterns and iterations.
import os
import re

SCALE = float(os.environ.get("BENCH_SCALE", "1"))
ITERS = max(20, round(900 * SCALE))

text = (
    "The quick brown fox 123 jumps over 456 the lazy dog. "
    "Email a@b.com and c.d@e.org; phone 555-1234, 555-9876. "
    "Numbers: 3.14, 2.718, 1000000. Words words WORDS Words. "
) * 20

patterns = [
    r"\b\d+\b",
    r"\b\w+@\w+\.\w+\b",
    r"\b[A-Z][a-z]+\b",
    r"\d{3}-\d{4}",
    r"\b\w{5,}\b",
]
compiled = [re.compile(p) for p in patterns]
acc = 0
for _ in range(ITERS):
    for rx in compiled:
        acc += len(rx.findall(text))
print(acc)
