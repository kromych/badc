
setjmp_longjmp.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400314 <.text+0x74>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x21, w1
               	add	x13, x20, #0x200
               	str	w21, [x13]
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x4005f8 <longjmp>
               	uxtb	w0, w0
               	mov	x12, x0
               	mov	x12, #0x0               // =0
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x270
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x40036c <.text+0xcc>
               	mov	x14, #0xb               // =11
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	sub	x21, x29, #0x208
               	mov	x0, x21
               	bl	0x400604 <setjmp>
               	sxtw	x0, w0
               	mov	x22, x0
               	sxtw	x21, w22
               	cmp	x21, #0x0
               	b.ne	0x4003d8 <.text+0x138>
               	sxtw	x21, w20
               	sub	x23, x29, #0x208
               	mov	x24, #0x7               // =7
               	mov	x0, x23
               	mov	x1, x24
               	bl	0x4002b8 <.text+0x18>
               	mov	x11, x0
               	mov	x11, #0xc               // =12
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x24, w22
               	cmp	x24, #0x7
               	b.eq	0x400410 <.text+0x170>
               	mov	x24, #0xd               // =13
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x11, w20
               	cmp	x11, #0x1
               	b.eq	0x400448 <.text+0x1a8>
               	mov	x11, #0xe               // =14
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x24, x29, #0x208
               	add	x11, x24, #0x200
               	ldrsw	x24, [x11]
               	cmp	x24, #0x7
               	b.eq	0x400488 <.text+0x1e8>
               	mov	x24, #0xf               // =15
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x11, #0x0               // =0
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
