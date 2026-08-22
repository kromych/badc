
alloca_alignment.aarch64:	file format elf64-littleaarch64

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
               	str	x19, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x1, #0x1                // =1
               	add	x17, x1, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x4, sp
               	sub	x4, x4, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x4
               	mov	x0, #0x7                // =7
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x0
               	mov	x2, #0x21               // =33
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x2, sp
               	sub	x2, x2, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x2
               	mov	x3, #0x64               // =100
               	add	x17, x3, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x3, sp
               	sub	x3, x3, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x3
               	mov	x17, #0xf               // =15
               	and	x5, x4, x17
               	mov	x17, #0xf               // =15
               	and	x6, x0, x17
               	orr	x5, x5, x6
               	mov	x17, #0xf               // =15
               	and	x6, x2, x17
               	orr	x5, x5, x6
               	mov	x17, #0xf               // =15
               	and	x6, x3, x17
               	orr	x5, x5, x6
               	cbz	x5, <addr>
               	mov	x0, x1
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x1, #0x0                // =0
               	mov	x5, #0xb                // =11
               	strb	w5, [x4]
               	mov	x5, #0x16               // =22
               	strb	w5, [x0, #0x6]
               	mov	x5, #0x21               // =33
               	strb	w5, [x2, #0x20]
               	mov	x5, #0x2c               // =44
               	strb	w5, [x3, #0x63]
               	ldrb	w4, [x4]
               	mov	x17, #0xb               // =11
               	eor	x4, x4, x17
               	mov	w4, w4
               	cbnz	x4, <addr>
               	ldrb	w0, [x0, #0x6]
               	mov	x17, #0x16              // =22
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldrb	w0, [x2, #0x20]
               	mov	x17, #0x21              // =33
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldrb	w0, [x3, #0x63]
               	mov	x17, #0x2c              // =44
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	sxtw	x0, w1
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
