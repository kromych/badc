
builtin_ffs.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0xff0000           // =16711680
               	stur	w0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	mov	w0, w0
               	sub	x1, x0, #0x1
               	mvn	x2, x0
               	and	x1, x1, x2
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
               	add	x1, x1, #0x1
               	cmp	w0, #0x0
               	cset	x0, ne
               	mul	x0, x1, x0
               	cmp	w0, #0x11
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	mov	w0, w0
               	sub	x2, x0, #0x1
               	mvn	x3, x0
               	and	x2, x2, x3
               	mov	w2, w2
               	lsr	x3, x2, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	and	x3, x3, x17
               	sub	x2, x2, x3
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x3, x2, x17
               	lsr	x2, x2, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x2, x2, x17
               	add	x2, x3, x2
               	lsr	x3, x2, #4
               	add	x2, x2, x3
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x2, x2, x17
               	lsr	x3, x2, #8
               	add	x2, x2, x3
               	lsr	x3, x2, #16
               	add	x2, x2, x3
               	mov	x17, #0x7f              // =127
               	and	x2, x2, x17
               	add	x2, x2, #0x1
               	cmp	w0, #0x0
               	cset	x0, ne
               	mul	x0, x2, x0
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
