// C99 6.7.8p7: a designator list may continue into the designated array
// element (`[N].member = value`). An array whose element values are not
// all compile-time constants is filled by stores rather than staged
// bytes, and the chain has to resolve the same way on that path.
// drivers/cxl/acpi.c builds its `union acpi_object in_array[4]` this way,
// from members of a runtime struct.
struct integer {
	int type;
	long long value;
};

union obj {
	int type;
	struct integer integer;
};

struct coord {
	long long read_latency;
	long long write_latency;
};

static int build(const struct coord *c, long long *out) {
	union obj in_array[4] = {
		[0].integer = { 1, c->read_latency },
		[1].integer = { 1, c->write_latency },
		[3].integer = { 1, c->read_latency + c->write_latency },
	};
	out[0] = in_array[0].integer.value;
	out[1] = in_array[1].integer.value;
	out[2] = in_array[2].integer.value;
	out[3] = in_array[3].integer.value;
	return in_array[0].integer.type + in_array[3].integer.type;
}

int main(void) {
	struct coord c = { 40, 60 };
	long long out[4];

	if (build(&c, out) != 2) return 1;
	if (out[0] != 40) return 2;
	if (out[1] != 60) return 3;
	if (out[2] != 0) return 4;
	if (out[3] != 100) return 5;
	return 0;
}
