
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
               	add	x11, x12, #0x1
               	sxtw	x11, w11
               	str	w11, [x13]
               	cmp	x15, #0x0
               	b.le	0x40033c <.text+0x9c>
               	sub	x11, x15, #0x1
               	sxtw	x21, w11
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
               	bl	0x4007d8 <longjmp>
               	uxtb	w0, w0
               	b	0x400318 <.text+0x78>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
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
               	bl	0x4007e4 <setjmp>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	0x4003fc <.text+0x15c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e0
               	mov	x0, x19
               	mov	x20, #0x0               // =0
               	str	w20, [x0]
               	mov	x21, #0x5               // =5
               	mov	x22, #0x2a              // =42
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x4002b8 <.text+0x18>
               	mov	x0, #0xb                // =11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e0
               	mov	x22, x19
               	ldrsw	x0, [x22]
               	cmp	x0, #0x6
               	b.eq	0x400438 <.text+0x198>
               	mov	x0, #0xc                // =12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2f0
               	mov	x22, x19
               	mov	x0, #0x2                // =2
               	str	w0, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x4007e4 <setjmp>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	0x4004b0 <.text+0x210>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x21, x19
               	mov	x23, #0x0               // =0
               	mov	x0, x21
               	mov	x1, x23
               	bl	0x4007d8 <longjmp>
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x23, x19
               	mov	x0, #0x0                // =0
               	str	w0, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x22, x19
               	mov	x0, x22
               	bl	0x4007e4 <setjmp>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x40054c <.text+0x2ac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x0, x19
               	ldrsw	x22, [x0]
               	cmp	x22, #0x1
               	b.eq	0x4005cc <.text+0x32c>
               	b	0x4005a4 <.text+0x304>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2f0
               	mov	x23, x19
               	mov	x0, #0x3                // =3
               	str	w0, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x21, x19
               	mov	x0, #0x0                // =0
               	str	w0, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x22, x19
               	mov	x0, x22
               	bl	0x4007e4 <setjmp>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x400614 <.text+0x374>
               	b	0x4005d0 <.text+0x330>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x0, x19
               	mov	x22, #0x1               // =1
               	str	w22, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x21, x19
               	mov	x23, #0x0               // =0
               	mov	x0, x21
               	mov	x1, x23
               	bl	0x4007d8 <longjmp>
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
               	mov	x22, #0x16              // =22
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400500 <.text+0x260>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x0, x19
               	ldrsw	x22, [x0]
               	cmp	x22, #0x7
               	b.eq	0x400690 <.text+0x3f0>
               	b	0x400668 <.text+0x3c8>
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x0, x19
               	mov	x23, #0x7               // =7
               	str	w23, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x22, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x4007d8 <longjmp>
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
               	mov	x22, #0x20              // =32
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4005ec <.text+0x34c>
