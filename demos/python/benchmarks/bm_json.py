# JSON encode/decode round-trip (the _json C accelerator, string building,
# float formatting). Output is the encoded length and an accumulator over
# all iterations.
import json
import os

SCALE = float(os.environ.get("BENCH_SCALE", "1"))
ITERS = max(50, round(4000 * SCALE))


def make(i):
    return {
        "id": i,
        "name": "item-%d" % i,
        "values": [i * j for j in range(8)],
        "meta": {"even": i % 2 == 0, "tags": ["a", "b", "c"][: i % 3 + 1]},
        "ratio": (i + 1) / 7.0,
    }


data = [make(i) for i in range(20)]
acc = 0
s = ""
for _ in range(ITERS):
    s = json.dumps(data, separators=(",", ":"), sort_keys=True)
    back = json.loads(s)
    acc += len(s) + len(back)
print("%d %d" % (len(s), acc))
