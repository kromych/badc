
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
               	mov	x2, #0xff               // =255
               	movk	x2, #0xff, lsl #16
               	stur	w2, [x29, #-0x10]
               	ldur	w0, [x29, #-0x10]
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
               	cmp	w0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x10]
               	lsr	x1, x0, #1
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
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x10]
               	sub	x1, x0, #0x1
               	mvn	x0, x0
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
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x2, [x29, #-0x8]
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
               	cmp	w0, #0x10
               	b.eq	<addr>
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
               	cbz	x0, <addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
