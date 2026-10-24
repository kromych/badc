
gnu_capability_macros.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x60
               	mov	x0, #0x0                // =0
               	sturb	w0, [x29, #-0x48]
               	sub	x2, x29, #0x48
               	mov	x1, #0x1                // =1
               	swpalb	w1, w3, [x2]
               	and	x3, x3, #0xff
               	cbz	x3, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w3, [x29, #-0x48]
               	eor	x3, x3, #0x1
               	cbz	w3, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	swpalb	w1, w3, [x2]
               	and	x3, x3, #0xff
               	cbnz	w3, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stlrb	w0, [x2]
               	ldurb	w2, [x29, #-0x48]
               	cbz	w2, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sturb	w1, [x29, #-0x40]
               	sturh	w1, [x29, #-0x38]
               	stur	w1, [x29, #-0x30]
               	stur	x1, [x29, #-0x28]
               	sub	x3, x29, #0x40
               	mov	x2, #0x2                // =2
               	mov	x4, x1
               	casalb	w4, w2, [x3]
               	cmp	w4, #0x1
               	b.ne	<addr>
               	ldurb	w3, [x29, #-0x40]
               	eor	x3, x3, #0x2
               	cbz	w3, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x38
               	mov	x4, x1
               	casalh	w4, w2, [x3]
               	cmp	w4, #0x1
               	b.ne	<addr>
               	ldursh	x3, [x29, #-0x38]
               	cmp	w3, #0x2
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x30
               	mov	x4, x1
               	casal	w4, w2, [x3]
               	cmp	w4, #0x1
               	b.ne	<addr>
               	ldursw	x3, [x29, #-0x30]
               	cmp	w3, #0x2
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x28
               	mov	x4, x1
               	casal	x4, x2, [x3]
               	cmp	x4, #0x1
               	b.ne	<addr>
               	ldur	x3, [x29, #-0x28]
               	cmp	x3, #0x2
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x60
               	stur	x1, [x29, #-0x60]
               	stur	x0, [x29, #-0x58]
               	sub	x4, x29, #0x20
               	stur	x1, [x29, #-0x20]
               	stur	x0, [x29, #-0x18]
               	sub	x1, x29, #0x10
               	stur	x2, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x3
               	mov	x14, x4
               	mov	x15, x1
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	mov	x1, x16
               	cbz	w1, <addr>
               	ldur	x1, [x29, #-0x60]
               	ldur	x2, [x29, #-0x58]
               	eor	x1, x1, #0x2
               	orr	x1, x1, x2
               	cbz	x1, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
