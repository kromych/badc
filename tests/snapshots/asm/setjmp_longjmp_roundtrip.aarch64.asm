
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
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x15, <page>
               	add	x15, x15, #0x2f0
               	mov	x14, #0x1               // =1
               	str	w14, [x15]
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x14, x0
               	cmp	x14, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2e0
               	mov	x14, #0x0               // =0
               	str	w14, [x0]
               	mov	x0, #0x5                // =5
               	mov	x1, #0x2a               // =42
               	bl	<addr>
               	mov	x15, x0
               	mov	x15, #0xb               // =11
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, #0x2e0
               	ldrsw	x1, [x1]
               	cmp	x1, #0x6
               	b.eq	<addr>
               	mov	x15, #0xc               // =12
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, #0x2f0
               	mov	x15, #0x2               // =2
               	str	w15, [x1]
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x15, x0
               	cmp	x15, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	uxtb	w0, w0
               	mov	x15, x0
               	mov	x15, #0x15              // =21
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, #0x2e8
               	mov	x15, #0x0               // =0
               	str	w15, [x1]
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x15, x0
               	cmp	x15, #0x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2e8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x2f0
               	mov	x15, #0x3               // =3
               	str	w15, [x1]
               	adrp	x0, <page>
               	add	x0, x0, #0x2e8
               	mov	x15, #0x0               // =0
               	str	w15, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x15, x0
               	cmp	x15, #0x0
               	b.eq	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2e8
               	mov	x15, #0x1               // =1
               	str	w15, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	uxtb	w0, w0
               	mov	x15, x0
               	mov	x15, #0x17              // =23
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x16              // =22
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2e8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x2e8
               	mov	x1, #0x7                // =7
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	bl	<addr>
               	uxtb	w0, w0
               	mov	x15, x0
               	mov	x15, #0x1f              // =31
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x20              // =32
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
