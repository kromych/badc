
builtin_bit_count.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0xff               // =255
               	movk	x0, #0xff, lsl #16
               	stur	w0, [x29, #-0x10]
               	ldur	w1, [x29, #-0x10]
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
               	sxtw	x1, w1
               	cmp	x1, #0x10
               	cset	x1, eq
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w1, [x29, #-0x10]
               	lsr	x2, x1, #1
               	orr	x1, x1, x2
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
               	sxtw	x1, w1
               	cmp	x1, #0x8
               	cset	x1, eq
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w1, [x29, #-0x10]
               	sub	x2, x1, #0x1
               	mvn	x1, x1
               	and	x1, x2, x1
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
               	sxtw	x1, w1
               	cmp	x1, #0x0
               	cset	x1, eq
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
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
               	sxtw	x0, w0
               	cmp	x0, #0x10
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	sub	x1, x0, #0x1
               	mvn	x0, x0
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
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
