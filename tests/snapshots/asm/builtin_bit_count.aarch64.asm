
builtin_bit_count.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	sxtw	x1, w1
               	cmp	x0, x1
               	cset	x0, eq
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x1                // =1
               	mov	x1, #0x0                // =0
               	orr	x0, x0, x1
               	lsr	x1, x0, #2
               	orr	x0, x0, x1
               	lsr	x1, x0, #4
               	orr	x0, x0, x1
               	lsr	x1, x0, #8
               	orr	x0, x0, x1
               	lsr	x1, x0, #16
               	orr	x0, x0, x1
               	mov	w0, w0
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	and	x1, x1, x17
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x20               // =32
               	sub	x0, x1, x0
               	mov	x1, #0x1f               // =31
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x80000000         // =2147483648
               	mov	x1, #0x40000000         // =1073741824
               	orr	x0, x0, x1
               	lsr	x1, x0, #2
               	orr	x0, x0, x1
               	lsr	x1, x0, #4
               	orr	x0, x0, x1
               	lsr	x1, x0, #8
               	orr	x0, x0, x1
               	lsr	x1, x0, #16
               	orr	x0, x0, x1
               	mov	w0, w0
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	and	x1, x1, x17
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x20               // =32
               	sub	x0, x1, x0
               	mov	x1, #0x0                // =0
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x10000            // =65536
               	mov	x1, #0x8000             // =32768
               	orr	x0, x0, x1
               	lsr	x1, x0, #2
               	orr	x0, x0, x1
               	lsr	x1, x0, #4
               	orr	x0, x0, x1
               	lsr	x1, x0, #8
               	orr	x0, x0, x1
               	lsr	x1, x0, #16
               	orr	x0, x0, x1
               	mov	w0, w0
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	and	x1, x1, x17
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x20               // =32
               	sub	x0, x1, x0
               	mov	x1, #0xf                // =15
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0x7fff, lsl #16
               	orr	x0, x0, x1
               	lsr	x1, x0, #2
               	orr	x0, x0, x1
               	lsr	x1, x0, #4
               	orr	x0, x0, x1
               	lsr	x1, x0, #8
               	orr	x0, x0, x1
               	lsr	x1, x0, #16
               	orr	x0, x0, x1
               	mov	w0, w0
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	and	x1, x1, x17
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x20               // =32
               	sub	x0, x1, x0
               	mov	x1, #0x0                // =0
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0xfffe             // =65534
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	and	x1, x0, x1
               	mov	w1, w1
               	lsr	x2, x1, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	and	x2, x2, x17
               	sub	x1, x1, x2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x2, x1, x17
               	lsr	x1, x1, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x1, x1, x17
               	add	x1, x2, x1
               	lsr	x2, x1, #4
               	add	x1, x1, x2
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x1, x1, x17
               	lsr	x2, x1, #8
               	add	x1, x1, x2
               	lsr	x2, x1, #16
               	add	x1, x1, x2
               	mov	x17, #0x7f              // =127
               	and	x1, x1, x17
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x7fff, lsl #16
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0x7fff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	and	x0, x0, x1
               	mov	w0, w0
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	and	x1, x1, x17
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x1f               // =31
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xfffe, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	and	x0, x0, x1
               	mov	w0, w0
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	and	x1, x1, x17
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x10               // =16
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x3fff, lsl #16
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xbfff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	and	x0, x0, x1
               	mov	w0, w0
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	and	x1, x1, x17
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x1e               // =30
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x1, x0, x0
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x2, x1, x17
               	lsr	x1, x1, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x1, x1, x17
               	add	x1, x2, x1
               	lsr	x2, x1, #4
               	add	x1, x1, x2
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x1, x1, x17
               	lsr	x2, x1, #8
               	add	x1, x1, x2
               	lsr	x2, x1, #16
               	add	x1, x1, x2
               	mov	x17, #0x7f              // =127
               	and	x1, x1, x17
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	mov	x1, #0x5555             // =21845
               	movk	x1, #0x5555, lsl #16
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x20               // =32
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf0f              // =3855
               	movk	x0, #0xf0f, lsl #16
               	mov	x1, #0x505              // =1285
               	movk	x1, #0x505, lsl #16
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x10               // =16
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	mov	x1, #0x3                // =3
               	mov	x2, #0x1                // =1
               	sub	x0, x0, x2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x2, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x0, x0, x17
               	add	x0, x2, x0
               	lsr	x2, x0, #4
               	add	x0, x0, x2
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x0, x0, x17
               	lsr	x2, x0, #8
               	add	x0, x0, x2
               	lsr	x2, x0, #16
               	add	x0, x0, x2
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x0                // =0
               	orr	x0, x0, x1
               	lsr	x1, x0, #2
               	orr	x0, x0, x1
               	lsr	x1, x0, #4
               	orr	x0, x0, x1
               	lsr	x1, x0, #8
               	orr	x0, x0, x1
               	lsr	x1, x0, #16
               	orr	x0, x0, x1
               	lsr	x1, x0, #32
               	orr	x0, x0, x1
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	movk	x17, #0x5555, lsl #32
               	movk	x17, #0x5555, lsl #48
               	and	x1, x1, x17
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	movk	x17, #0xf0f, lsl #32
               	movk	x17, #0xf0f, lsl #48
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	lsr	x1, x0, #32
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x40               // =64
               	sub	x0, x1, x0
               	mov	x1, #0x3f               // =63
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	orr	x0, x0, x1
               	lsr	x1, x0, #2
               	orr	x0, x0, x1
               	lsr	x1, x0, #4
               	orr	x0, x0, x1
               	lsr	x1, x0, #8
               	orr	x0, x0, x1
               	lsr	x1, x0, #16
               	orr	x0, x0, x1
               	lsr	x1, x0, #32
               	orr	x0, x0, x1
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	movk	x17, #0x5555, lsl #32
               	movk	x17, #0x5555, lsl #48
               	and	x1, x1, x17
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	movk	x17, #0xf0f, lsl #32
               	movk	x17, #0xf0f, lsl #48
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	lsr	x1, x0, #32
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x40               // =64
               	sub	x0, x1, x0
               	mov	x1, #0x0                // =0
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x100000000        // =4294967296
               	mov	x1, #0x80000000         // =2147483648
               	orr	x0, x0, x1
               	lsr	x1, x0, #2
               	orr	x0, x0, x1
               	lsr	x1, x0, #4
               	orr	x0, x0, x1
               	lsr	x1, x0, #8
               	orr	x0, x0, x1
               	lsr	x1, x0, #16
               	orr	x0, x0, x1
               	lsr	x1, x0, #32
               	orr	x0, x0, x1
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	movk	x17, #0x5555, lsl #32
               	movk	x17, #0x5555, lsl #48
               	and	x1, x1, x17
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	movk	x17, #0xf0f, lsl #32
               	movk	x17, #0xf0f, lsl #48
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	lsr	x1, x0, #32
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x40               // =64
               	sub	x0, x1, x0
               	mov	x1, #0x1f               // =31
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0xfffe             // =65534
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	and	x1, x0, x1
               	lsr	x2, x1, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	movk	x17, #0x5555, lsl #32
               	movk	x17, #0x5555, lsl #48
               	and	x2, x2, x17
               	sub	x1, x1, x2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x2, x1, x17
               	lsr	x1, x1, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x1, x1, x17
               	add	x1, x2, x1
               	lsr	x2, x1, #4
               	add	x1, x1, x2
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	movk	x17, #0xf0f, lsl #32
               	movk	x17, #0xf0f, lsl #48
               	and	x1, x1, x17
               	lsr	x2, x1, #8
               	add	x1, x1, x2
               	lsr	x2, x1, #16
               	add	x1, x1, x2
               	lsr	x2, x1, #32
               	add	x1, x1, x2
               	mov	x17, #0x7f              // =127
               	and	x1, x1, x17
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0x7fff, lsl #48
               	and	x0, x0, x0
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	movk	x17, #0x5555, lsl #32
               	movk	x17, #0x5555, lsl #48
               	and	x1, x1, x17
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	movk	x17, #0xf0f, lsl #32
               	movk	x17, #0xf0f, lsl #48
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	lsr	x1, x0, #32
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x3f               // =63
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xfffe, lsl #32
               	movk	x1, #0xffff, lsl #48
               	and	x0, x0, x1
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	movk	x17, #0x5555, lsl #32
               	movk	x17, #0x5555, lsl #48
               	and	x1, x1, x17
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	movk	x17, #0xf0f, lsl #32
               	movk	x17, #0xf0f, lsl #48
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	lsr	x1, x0, #32
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x20               // =32
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x1, #0x5555             // =21845
               	movk	x1, #0x5555, lsl #16
               	movk	x1, #0x5555, lsl #32
               	movk	x1, #0x5555, lsl #48
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	movk	x17, #0xf0f, lsl #32
               	movk	x17, #0xf0f, lsl #48
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	lsr	x1, x0, #32
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x40               // =64
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xcafe             // =51966
               	movk	x0, #0xbeef, lsl #16
               	movk	x0, #0xdead, lsl #32
               	mov	x1, #0x4555             // =17749
               	movk	x1, #0x5555, lsl #16
               	movk	x1, #0x4554, lsl #32
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	movk	x17, #0xf0f, lsl #32
               	movk	x17, #0xf0f, lsl #48
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	lsr	x1, x0, #32
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x23               // =35
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xff               // =255
               	movk	x0, #0xff, lsl #16
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	and	x1, x1, x17
               	sub	x1, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x2, x1, x17
               	lsr	x1, x1, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x1, x1, x17
               	add	x1, x2, x1
               	lsr	x2, x1, #4
               	add	x1, x1, x2
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x1, x1, x17
               	lsr	x2, x1, #8
               	add	x1, x1, x2
               	lsr	x2, x1, #16
               	add	x1, x1, x2
               	mov	x17, #0x7f              // =127
               	and	x1, x1, x17
               	mov	x2, #0x10               // =16
               	cmp	x1, x2
               	cset	x1, eq
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsr	x1, x0, #1
               	orr	x1, x0, x1
               	lsr	x2, x1, #2
               	orr	x1, x1, x2
               	lsr	x2, x1, #4
               	orr	x1, x1, x2
               	lsr	x2, x1, #8
               	orr	x1, x1, x2
               	lsr	x2, x1, #16
               	orr	x1, x1, x2
               	mov	w1, w1
               	lsr	x2, x1, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	and	x2, x2, x17
               	sub	x1, x1, x2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x2, x1, x17
               	lsr	x1, x1, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x1, x1, x17
               	add	x1, x2, x1
               	lsr	x2, x1, #4
               	add	x1, x1, x2
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x1, x1, x17
               	lsr	x2, x1, #8
               	add	x1, x1, x2
               	lsr	x2, x1, #16
               	add	x1, x1, x2
               	mov	x17, #0x7f              // =127
               	and	x1, x1, x17
               	mov	x2, #0x20               // =32
               	sub	x1, x2, x1
               	mov	x2, #0x8                // =8
               	cmp	x1, x2
               	cset	x1, eq
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x0, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x0, x0, x17
               	and	x0, x1, x0
               	mov	w0, w0
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	and	x1, x1, x17
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x0                // =0
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0xfffe             // =65534
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	and	x1, x0, x1
               	lsr	x2, x1, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	movk	x17, #0x5555, lsl #32
               	movk	x17, #0x5555, lsl #48
               	and	x2, x2, x17
               	sub	x1, x1, x2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x2, x1, x17
               	lsr	x1, x1, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x1, x1, x17
               	add	x1, x2, x1
               	lsr	x2, x1, #4
               	add	x1, x1, x2
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	movk	x17, #0xf0f, lsl #32
               	movk	x17, #0xf0f, lsl #48
               	and	x1, x1, x17
               	lsr	x2, x1, #8
               	add	x1, x1, x2
               	lsr	x2, x1, #16
               	add	x1, x1, x2
               	lsr	x2, x1, #32
               	add	x1, x1, x2
               	mov	x17, #0x7f              // =127
               	and	x1, x1, x17
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xfffe, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	and	x0, x0, x1
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	movk	x17, #0x5555, lsl #32
               	movk	x17, #0x5555, lsl #48
               	and	x1, x1, x17
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	movk	x17, #0xf0f, lsl #32
               	movk	x17, #0xf0f, lsl #48
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	lsr	x1, x0, #32
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x10               // =16
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	mov	x1, #0x3                // =3
               	mov	x2, #0x1                // =1
               	sub	x0, x0, x2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x2, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x0, x0, x17
               	add	x0, x2, x0
               	lsr	x2, x0, #4
               	add	x0, x0, x2
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	movk	x17, #0xf0f, lsl #32
               	movk	x17, #0xf0f, lsl #48
               	and	x0, x0, x17
               	lsr	x2, x0, #8
               	add	x0, x0, x2
               	lsr	x2, x0, #16
               	add	x0, x0, x2
               	lsr	x2, x0, #32
               	add	x0, x0, x2
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf0f              // =3855
               	movk	x0, #0xf0f, lsl #16
               	mov	x1, #0x505              // =1285
               	movk	x1, #0x505, lsl #16
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	movk	x17, #0xf0f, lsl #32
               	movk	x17, #0xf0f, lsl #48
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	lsr	x1, x0, #32
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x10               // =16
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xff               // =255
               	movk	x0, #0xff, lsl #16
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	movk	x17, #0x5555, lsl #32
               	movk	x17, #0x5555, lsl #48
               	and	x1, x1, x17
               	sub	x1, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x2, x1, x17
               	lsr	x1, x1, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x1, x1, x17
               	add	x1, x2, x1
               	lsr	x2, x1, #4
               	add	x1, x1, x2
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	movk	x17, #0xf0f, lsl #32
               	movk	x17, #0xf0f, lsl #48
               	and	x1, x1, x17
               	lsr	x2, x1, #8
               	add	x1, x1, x2
               	lsr	x2, x1, #16
               	add	x1, x1, x2
               	lsr	x2, x1, #32
               	add	x1, x1, x2
               	mov	x17, #0x7f              // =127
               	and	x1, x1, x17
               	mov	x2, #0x10               // =16
               	cmp	x1, x2
               	cset	x1, eq
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x0, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x0, x0, x17
               	and	x0, x1, x0
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	movk	x17, #0x5555, lsl #32
               	movk	x17, #0x5555, lsl #48
               	and	x1, x1, x17
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	movk	x17, #0xf0f, lsl #32
               	movk	x17, #0xf0f, lsl #48
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	lsr	x1, x0, #32
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x0                // =0
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
