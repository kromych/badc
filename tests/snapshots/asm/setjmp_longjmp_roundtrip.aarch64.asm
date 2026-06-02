
setjmp_longjmp_roundtrip.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x15, w0
               	sxtw	x20, w1
               	adrp	x13, <page>
               	add	x13, x13, #0x2e0
               	ldrsw	x12, [x13]
               	add	x12, x12, #0x1
               	sxtw	x12, w12
               	str	w12, [x13]
               	cmp	x15, #0x0
               	b.le	<addr>
               	sub	x15, x15, #0x1
               	sxtw	x0, w15
               	mov	x1, x20
               	bl	<addr>
               	mov	x15, x0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	mov	x1, x20
               	bl	<addr>
               	uxtb	w0, w0
               	mov	x15, x0
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	adrp	x20, <page>
               	add	x20, x20, #0x2f0
               	mov	x14, #0x1               // =1
               	str	w14, [x20]
               	adrp	x21, <page>
               	add	x21, x21, #0xe0
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x12, <page>
               	add	x12, x12, #0x2e0
               	mov	x0, #0x0                // =0
               	str	w0, [x12]
               	mov	x0, #0x5                // =5
               	mov	x1, #0x2a               // =42
               	bl	<addr>
               	mov	x12, x0
               	mov	x12, #0xb               // =11
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, #0x2e0
               	ldrsw	x1, [x1]
               	cmp	x1, #0x6
               	b.eq	<addr>
               	mov	x12, #0xc               // =12
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x2                // =2
               	str	w1, [x20]
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x21
               	bl	<addr>
               	uxtb	w0, w0
               	mov	x0, #0x15               // =21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, #0x2e8
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	adrp	x12, <page>
               	add	x12, x12, #0x2e8
               	ldrsw	x12, [x12]
               	cmp	x12, #0x1
               	b.eq	<addr>
               	b	<addr>
               	mov	x1, #0x3                // =3
               	str	w1, [x20]
               	adrp	x0, <page>
               	add	x0, x0, #0x2e8
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	b	<addr>
               	adrp	x12, <page>
               	add	x12, x12, #0x2e8
               	mov	x0, #0x1                // =1
               	str	w0, [x12]
               	mov	x1, #0x0                // =0
               	mov	x0, x21
               	bl	<addr>
               	uxtb	w0, w0
               	mov	x0, #0x17               // =23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x16               // =22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x2e8
               	ldrsw	x1, [x1]
               	cmp	x1, #0x7
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, #0x2e8
               	mov	x0, #0x7                // =7
               	str	w0, [x1]
               	mov	x1, x0
               	mov	x0, x21
               	bl	<addr>
               	uxtb	w0, w0
               	mov	x20, x0
               	mov	x20, #0x1f              // =31
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x20               // =32
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
