# String building, formatting, splitting and joining (str methods, the
# unicode object). Output is an accumulator and the final string length.
import os

SCALE = float(os.environ.get("BENCH_SCALE", "1"))
ITERS = max(50, round(15000 * SCALE))

words = ["alpha", "beta", "gamma", "delta", "epsilon", "zeta", "eta", "theta"]
acc = 0
last = ""
for n in range(ITERS):
    parts = []
    for i in range(len(words)):
        parts.append("%s-%d" % (words[i], (n + i) % 97))
    joined = ",".join(parts)
    upper = joined.upper()
    split = upper.split(",")
    rejoined = "|".join(reversed(split))
    last = rejoined
    acc += len(rejoined) + sum(1 for c in rejoined if c == "A")
print("%d %d" % (acc, len(last)))
