// The GNU range designator `[lo ... hi]` inside a designator list, not
// only as a whole-array designator: one entry value fills every index in
// the range, and any step after it applies to each. The shape
// security/integrity/ima/ima_queue.c initializes its hash table with:
// `.queue[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT`.
#define TABLE 4

struct hlist_head {
	void *first;
};

struct h_table {
	long len;
	struct hlist_head queue[TABLE];
	long violations;
};

static struct h_table htable = {
	.len = 5,
	.queue[0 ... TABLE - 1] = { .first = 0 },
	.violations = 7,
};

struct cell {
	int a;
	int b;
};

struct outer {
	int head;
	struct cell c[3];
	int tail;
};

static struct outer o = {
	.head = 1,
	.c[0 ... 2] = { 7, 8 },
	.tail = 9,
};

int main(void) {
	int i;
	for (i = 0; i < TABLE; i++)
		if (htable.queue[i].first != 0) return 1;
	if (htable.len != 5 || htable.violations != 7) return 2;
	for (i = 0; i < 3; i++)
		if (o.c[i].a != 7 || o.c[i].b != 8) return 3;
	if (o.head != 1 || o.tail != 9) return 4;
	return 0;
}
