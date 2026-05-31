
setjmp_longjmp_roundtrip.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40035c <.text+0xbc>
               	adrp	x16, 0x410000
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e0
               	mov	x13, x19
               	ldrsw	x12, [x13]
               	add	x12, x12, #0x1
               	sxtw	x12, w12
               	str	w12, [x13]
               	cmp	x15, #0x0
               	b.le	0x40033c <.text+0x9c>
               	sub	x15, x15, #0x1
               	sxtw	x21, w15
               	mov	x0, x21
               	mov	x1, x20
               	bl	0x4002b8 <.text+0x18>
               	b	0x400318 <.text+0x78>
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x22, x19
               	mov	x0, x22
               	mov	x1, x20
               	bl	0x4007b8 <longjmp>
               	uxtb	w0, w0
               	b	0x400318 <.text+0x78>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2f0
               	mov	x15, x19
               	mov	x14, #0x1               // =1
               	str	w14, [x15]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x4007c4 <setjmp>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	0x4003f4 <.text+0x154>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e0
               	mov	x20, x19
               	mov	x0, #0x0                // =0
               	str	w0, [x20]
               	mov	x21, #0x5               // =5
               	mov	x22, #0x2a              // =42
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x4002b8 <.text+0x18>
               	mov	x0, #0xb                // =11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e0
               	mov	x22, x19
               	ldrsw	x0, [x22]
               	cmp	x0, #0x6
               	b.eq	0x400430 <.text+0x190>
               	mov	x22, #0xc               // =12
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2f0
               	mov	x0, x19
               	mov	x22, #0x2               // =2
               	str	w22, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x4007c4 <setjmp>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	0x4004a4 <.text+0x204>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x21, x19
               	mov	x20, #0x0               // =0
               	mov	x0, x21
               	mov	x1, x20
               	bl	0x4007b8 <longjmp>
               	uxtb	w0, w0
               	mov	x0, #0x15               // =21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x20, x19
               	mov	x0, #0x0                // =0
               	str	w0, [x20]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x22, x19
               	mov	x0, x22
               	bl	0x4007c4 <setjmp>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x400540 <.text+0x2a0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x22, x19
               	ldrsw	x0, [x22]
               	cmp	x0, #0x1
               	b.eq	0x4005b8 <.text+0x318>
               	b	0x400594 <.text+0x2f4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2f0
               	mov	x20, x19
               	mov	x0, #0x3                // =3
               	str	w0, [x20]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x21, x19
               	mov	x0, #0x0                // =0
               	str	w0, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x22, x19
               	mov	x0, x22
               	bl	0x4007c4 <setjmp>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x4005fc <.text+0x35c>
               	b	0x4005bc <.text+0x31c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x0, x19
               	mov	x22, #0x1               // =1
               	str	w22, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x21, x19
               	mov	x20, #0x0               // =0
               	mov	x0, x21
               	mov	x1, x20
               	bl	0x4007b8 <longjmp>
               	uxtb	w0, w0
               	mov	x0, #0x17               // =23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x16              // =22
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4004f4 <.text+0x254>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x22, x19
               	ldrsw	x0, [x22]
               	cmp	x0, #0x7
               	b.eq	0x400670 <.text+0x3d0>
               	b	0x40064c <.text+0x3ac>
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x0, x19
               	mov	x20, #0x7               // =7
               	str	w20, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x22, x19
               	mov	x0, x22
               	mov	x1, x20
               	bl	0x4007b8 <longjmp>
               	uxtb	w0, w0
               	mov	x0, #0x1f               // =31
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x20              // =32
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4005d8 <.text+0x338>
