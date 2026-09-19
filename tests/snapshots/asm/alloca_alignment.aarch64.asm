
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x1                // =1
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
               	mov	x1, #0x7                // =7
               	add	x17, x1, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x1, sp
               	sub	x1, x1, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x1
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
               	and	x4, x0, #0xf
               	and	x5, x1, #0xf
               	orr	x4, x4, x5
               	and	x5, x2, #0xf
               	orr	x4, x4, x5
               	and	x5, x3, #0xf
               	orr	x4, x4, x5
               	cbz	x4, <addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0xb                // =11
               	strb	w4, [x0]
               	mov	x4, #0x16               // =22
               	strb	w4, [x1, #0x6]
               	mov	x4, #0x21               // =33
               	strb	w4, [x2, #0x20]
               	mov	x4, #0x2c               // =44
               	strb	w4, [x3, #0x63]
               	ldrb	w0, [x0]
               	mov	x17, #0xb               // =11
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x1, #0x6]
               	mov	x17, #0x16              // =22
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x2, #0x20]
               	mov	x17, #0x21              // =33
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
