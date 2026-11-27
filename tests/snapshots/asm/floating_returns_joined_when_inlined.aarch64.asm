
floating_returns_joined_when_inlined.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<slow>:
               	ldr	x0, [x0, #0x8]
               	scvtf	d0, x0
               	fmov	d1, #0.50000000
               	fmul	d0, d0, d1
               	ret

<sum>:
               	str	d8, [sp, #-0x40]!
               	stp	x20, x21, [sp, #0x10]
               	str	x22, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x21, x0
               	mov	x22, x1
               	mov	x20, #0x0               // =0
               	movi	d8, #0000000000000000
               	b	<addr>
               	fadd	d8, d8, d0
               	add	x20, x20, #0x1
               	cmp	w20, w22
               	b.ge	<addr>
               	add	x0, x21, x20, lsl #5
               	ldrsw	x2, [x0]
               	cmp	w2, #0x1
               	b.ne	<addr>
               	ldr	d0, [x0, #0x10]
               	b	<addr>
               	cmp	w2, #0x2
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	scvtf	d0, x0
               	b	<addr>
               	cmp	w2, #0x3
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	cmp	w2, #0x4
               	b.ne	<addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	fmov	d0, x17
               	b	<addr>
               	movi	d0, #0000000000000000
               	b	<addr>
               	fmov	d0, d8
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x40
               	ret

<fsum>:
               	mov	x2, #0x0                // =0
               	movi	d0, #0000000000000000
               	b	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, w1
               	b.ge	<addr>
               	add	x4, x0, x2, lsl #5
               	ldrsw	x3, [x4]
               	cmp	w3, #0x5
               	b.eq	<addr>
               	cmp	w3, #0x1
               	b.ne	<addr>
               	ldr	s1, [x4, #0x18]
               	fadd	s0, s0, s1
               	b	<addr>
               	cmp	w3, #0x2
               	b.ne	<addr>
               	ldr	x3, [x4, #0x8]
               	scvtf	s1, x3
               	b	<addr>
               	cmp	w3, #0x5
               	b.ne	<addr>
               	mov	x17, #0x7fc00000        // =2143289344
               	fmov	s1, w17
               	b	<addr>
               	fmov	s1, #2.50000000
               	b	<addr>
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	sub	x0, x29, #0xa0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x1, #0x40]
               	stp	x16, x17, [x0, #0x40]
               	ldp	x16, x17, [x1, #0x50]
               	stp	x16, x17, [x0, #0x50]
               	ldp	x16, x17, [x1, #0x60]
               	stp	x16, x17, [x0, #0x60]
               	ldp	x16, x17, [x1, #0x70]
               	stp	x16, x17, [x0, #0x70]
               	ldp	x16, x17, [x1, #0x80]
               	stp	x16, x17, [x0, #0x80]
               	ldp	x16, x17, [x1, #0x90]
               	stp	x16, x17, [x0, #0x90]
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0xc0]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa0
               	add	x0, x0, #0x60
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldr	d0, [x0, #0x10]
               	fmov	x0, d0
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa0
               	add	x0, x0, #0x80
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldr	d0, [x0, #0x10]
               	fmov	x0, d0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa0
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	mov	x16, #0x41740000        // =1098121216
               	fmov	s1, w16
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xc0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	mov	x17, #0x7fc00000        // =2143289344
               	fmov	s0, w17
               	fcmp	s0, s0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	scvtf	d0, x0
               	b	<addr>
               	cmp	w1, #0x3
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	cmp	w1, #0x4
               	b.ne	<addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	fmov	d0, x17
               	b	<addr>
               	movi	d0, #0000000000000000
               	b	<addr>
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	scvtf	d0, x0
               	b	<addr>
               	cmp	w1, #0x3
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	cmp	w1, #0x4
               	b.ne	<addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	fmov	d0, x17
               	b	<addr>
               	movi	d0, #0000000000000000
               	b	<addr>
