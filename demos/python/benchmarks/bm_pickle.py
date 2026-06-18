# Pickle serialize/deserialize round-trip (the _pickle C accelerator).
# Output is the pickled length and an accumulator over all iterations.
import os
import pickle

SCALE = float(os.environ.get("BENCH_SCALE", "1"))
ITERS = max(50, round(8000 * SCALE))

data = {
    "ints": list(range(100)),
    "floats": [i / 3.0 for i in range(50)],
    "strs": ["s%d" % i for i in range(50)],
    "nested": {"a": (1, 2, 3), "b": [True, False, None]},
}
acc = 0
blob = b""
for _ in range(ITERS):
    blob = pickle.dumps(data, protocol=4)
    back = pickle.loads(blob)
    acc += len(blob)
print("%d %d" % (len(blob), acc))
