
setjmp_longjmp.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40030c <.text+0x6c>
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
               	bl	0x4005d8 <longjmp>
               	uxtb	w0, w0
               	mov	x0, #0x0                // =0
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
               	cbz	x15, 0x400364 <.text+0xc4>
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
               	bl	0x4005e4 <setjmp>
               	sxtw	x0, w0
               	mov	x22, x0
               	sxtw	x21, w22
               	cmp	x21, #0x0
               	b.ne	0x4003c8 <.text+0x128>
               	sxtw	x12, w20
               	sub	x23, x29, #0x208
               	mov	x24, #0x7               // =7
               	mov	x0, x23
               	mov	x1, x24
               	bl	0x4002b8 <.text+0x18>
               	mov	x0, #0xc                // =12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x22, w22
               	cmp	x22, #0x7
               	b.eq	0x4003fc <.text+0x15c>
               	mov	x0, #0xd                // =13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x20, w20
               	cmp	x20, #0x1
               	b.eq	0x400430 <.text+0x190>
               	mov	x0, #0xe                // =14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x208
               	add	x20, x20, #0x200
               	ldrsw	x0, [x20]
               	cmp	x0, #0x7
               	b.eq	0x400470 <.text+0x1d0>
               	mov	x20, #0xf               // =15
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
