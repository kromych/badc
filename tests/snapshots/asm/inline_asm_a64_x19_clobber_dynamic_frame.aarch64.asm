
inline_asm_a64_x19_clobber_dynamic_frame.aarch64:	file format elf64-littleaarch64

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

<clobbered>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x30
               	mov	x0, #0x20               // =32
               	mov	x1, #0x5                // =5
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	x1, [x17, #-0x20]
               	mov	x1, #0x7                // =7
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	x1, [x17, #-0x18]
               	mov	x1, #0xb                // =11
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	x1, [x17, #-0x10]
               	mov	x1, #0x1                // =1
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	strb	w1, [x17]
               	add	x17, x0, #0xf
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
               	mov	x0, #0x0                // =0
               	mov	x2, #0x3                // =3
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	stur	x19, [x16, #-0x30]
               	mov	x19, #0x0               // =0
               	mov	x0, #0x2a               // =42
               	sub	x19, x29, #0x1, lsl #12 // =0x1000
               	ldur	x19, [x19, #-0x30]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x2, [x16, #-0x20]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x3, [x16, #-0x18]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x4, [x16, #-0x10]
               	add	x3, x3, x4
               	add	x0, x3, x0
               	add	x0, x2, x0
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	x0, [x17, #-0x20]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x0, [x16, #-0x18]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x2, [x16, #-0x20]
               	add	x0, x0, x2
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	x0, [x17, #-0x18]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x0, [x16, #-0x10]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x2, [x16, #-0x18]
               	add	x0, x0, x2
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	x0, [x17, #-0x10]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x0, [x16, #-0x20]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x2, [x16, #-0x18]
               	add	x0, x0, x2
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x2, [x16, #-0x10]
               	add	x0, x0, x2
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldrb	w1, [x16]
               	add	x0, x0, x1
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<jumped>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x30
               	mov	x0, #0x20               // =32
               	sxtw	x1, w1
               	mov	x2, #0x5                // =5
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	x2, [x17, #-0x20]
               	mov	x2, #0x7                // =7
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	x2, [x17, #-0x18]
               	mov	x2, #0xb                // =11
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	x2, [x17, #-0x10]
               	mov	x2, #0x1                // =1
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	strb	w2, [x17]
               	add	x17, x0, #0xf
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
               	mov	x0, #0x0                // =0
               	mov	x3, #0x3                // =3
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	stur	x19, [x16, #-0x28]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	stur	x1, [x16, #-0x30]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	ldur	x0, [x0, #-0x30]
               	mov	x19, #0x0               // =0
               	cbnz	w0, <addr>
               	sub	x19, x29, #0x1, lsl #12 // =0x1000
               	ldur	x19, [x19, #-0x28]
               	b	<addr>
               	sub	x19, x29, #0x1, lsl #12 // =0x1000
               	ldur	x19, [x19, #-0x28]
               	b	<addr>
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x0, [x16, #-0x20]
               	add	x0, x0, #0x64
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	x0, [x17, #-0x20]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x0, [x16, #-0x20]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x1, [x16, #-0x18]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x3, [x16, #-0x10]
               	add	x1, x1, x3
               	add	x0, x0, x1
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	x0, [x17, #-0x20]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x0, [x16, #-0x18]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x1, [x16, #-0x20]
               	add	x0, x0, x1
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	x0, [x17, #-0x18]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x0, [x16, #-0x10]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x1, [x16, #-0x18]
               	add	x0, x0, x1
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	stur	x0, [x17, #-0x10]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x0, [x16, #-0x20]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x1, [x16, #-0x18]
               	add	x0, x0, x1
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldur	x1, [x16, #-0x10]
               	add	x0, x0, x1
               	ldrb	w1, [x2]
               	add	x0, x0, x1
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldrb	w1, [x16]
               	add	x0, x0, x1
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x20               // =32
               	bl	<addr>
               	cmp	x0, #0xe0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x20               // =32
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x62
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x20               // =32
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x18e
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp], #0x10
               	ret
