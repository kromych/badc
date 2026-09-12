
stdatomic_c11.aarch64:	file format elf64-littleaarch64

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
               	str	x19, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x40]
               	sub	x0, x29, #0x40
               	mov	x2, #0x5                // =5
               	str	w2, [x0]
               	ldar	w1, [x0]
               	cmp	w1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	mov	x1, #0xa                // =10
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	add	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x1, x16
               	cmp	w1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	ldursw	x1, [x29, #-0x40]
               	cmp	w1, #0xf
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	mov	x1, #0xf                // =15
               	stur	w1, [x29, #-0x38]
               	sub	x1, x29, #0x38
               	mov	x3, #0x63               // =99
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	mov	x11, x3
               	ldr	w12, [x10]
               	ldaxr	w16, [x9]
               	cmp	x16, x12
               	b.ne	<addr>
               	stlxr	w17, w11, [x9]
               	cbnz	x17, <addr>
               	mov	x16, #0x1               // =1
               	b	<addr>
               	str	w16, [x10]
               	mov	x16, #0x0               // =0
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	ldursw	x0, [x29, #-0x40]
               	cmp	w0, #0x63
               	b.eq	<addr>
               	mov	x0, x2
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	dmb	ish
               	dmb	ishld
               	dmb	ish
               	mov	x1, #0x0                // =0
               	fmov	d16, x1
               	sub	x17, x29, #0x30
               	str	d16, [x17]
               	sub	x2, x29, #0x30
               	mov	x3, #0x4004000000000000 // =4612811918334230528
               	sub	x0, x29, #0x48
               	fmov	d16, x3
               	str	d16, [x0]
               	ldr	x4, [x0]
               	stlr	x4, [x2]
               	ldar	x2, [x2]
               	str	x2, [x0]
               	ldr	d0, [x0]
               	fmov	d17, x3
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	sub	x2, x29, #0x28
               	mov	x3, #0x3fa00000         // =1067450368
               	fmov	s16, w3
               	fneg	s0, s16
               	str	s0, [x0]
               	ldr	w3, [x0]
               	str	w3, [x2]
               	ldar	w3, [x2]
               	str	w3, [x0]
               	ldr	s1, [x0]
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	mov	x3, #0x40400000         // =1077936128
               	fmov	s16, w3
               	str	s16, [x0]
               	ldr	w0, [x0]
               	stlr	w0, [x2]
               	sub	x16, x29, #0x28
               	ldr	s0, [x16]
               	fmov	s17, w3
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	sub	x0, x29, #0x20
               	strb	w1, [x0]
               	mov	x2, #0x1                // =1
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x2
               	ldaxrb	w16, [x9]
               	stlxrb	w12, w10, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x3, x16
               	sxtb	x3, w3
               	cbz	x3, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	stlrb	w1, [x0]
               	stur	w1, [x29, #-0x18]
               	sub	x0, x29, #0x18
               	mov	x3, #0x2a               // =42
               	stlr	w3, [x0]
               	ldar	w0, [x0]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	sub	x0, x29, #0x10
               	mov	x3, #0x64               // =100
               	stlr	x3, [x0]
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x2
               	ldaxr	x16, [x9]
               	add	x11, x16, x10
               	stlxr	w12, x11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x3, x16
               	ldar	x3, [x0]
               	cmp	x3, #0x65
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	str	w2, [x0, #0x8]
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
