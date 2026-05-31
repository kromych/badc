
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
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x15, w0
               	sxtw	x20, w1
               	adrp	x19, <page>
               	add	x19, x19, #0x2e0
               	mov	x13, x19
               	ldrsw	x12, [x13]
               	add	x12, x12, #0x1
               	sxtw	x12, w12
               	str	w12, [x13]
               	cmp	x15, #0x0
               	b.le	<addr>
               	sub	x15, x15, #0x1
               	sxtw	x21, w15
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	b	<addr>
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xe0
               	mov	x22, x19
               	mov	x0, x22
               	mov	x1, x20
               	bl	<addr>
               	uxtb	w0, w0
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	adrp	x19, <page>
               	add	x19, x19, #0x2f0
               	mov	x15, x19
               	mov	x14, #0x1               // =1
               	str	w14, [x15]
               	adrp	x19, <page>
               	add	x19, x19, #0xe0
               	mov	x20, x19
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2e0
               	mov	x20, x19
               	mov	x0, #0x0                // =0
               	str	w0, [x20]
               	mov	x21, #0x5               // =5
               	mov	x22, #0x2a              // =42
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x2e0
               	mov	x22, x19
               	ldrsw	x22, [x22]
               	cmp	x22, #0x6
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x2f0
               	mov	x22, x19
               	mov	x0, #0x2                // =2
               	str	w0, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0xe0
               	mov	x20, x19
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xe0
               	mov	x21, x19
               	mov	x20, #0x0               // =0
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	uxtb	w0, w0
               	mov	x0, #0x15               // =21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x2e8
               	mov	x20, x19
               	mov	x0, #0x0                // =0
               	str	w0, [x20]
               	adrp	x19, <page>
               	add	x19, x19, #0xe0
               	mov	x22, x19
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2e8
               	mov	x22, x19
               	ldrsw	x22, [x22]
               	cmp	x22, #0x1
               	b.eq	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2f0
               	mov	x20, x19
               	mov	x0, #0x3                // =3
               	str	w0, [x20]
               	adrp	x19, <page>
               	add	x19, x19, #0x2e8
               	mov	x21, x19
               	mov	x0, #0x0                // =0
               	str	w0, [x21]
               	adrp	x19, <page>
               	add	x19, x19, #0xe0
               	mov	x22, x19
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2e8
               	mov	x22, x19
               	mov	x0, #0x1                // =1
               	str	w0, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0xe0
               	mov	x21, x19
               	mov	x20, #0x0               // =0
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	uxtb	w0, w0
               	mov	x0, #0x17               // =23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x16               // =22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2e8
               	mov	x22, x19
               	ldrsw	x22, [x22]
               	cmp	x22, #0x7
               	b.eq	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x2e8
               	mov	x22, x19
               	mov	x20, #0x7               // =7
               	str	w20, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0xe0
               	mov	x23, x19
               	mov	x0, x23
               	mov	x1, x20
               	bl	<addr>
               	uxtb	w0, w0
               	mov	x0, #0x1f               // =31
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x20               // =32
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
