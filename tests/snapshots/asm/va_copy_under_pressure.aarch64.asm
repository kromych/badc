
va_copy_under_pressure.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x70]
               	str	d4, [sp, #0x80]
               	str	d5, [sp, #0x90]
               	str	d6, [sp, #0xa0]
               	str	d7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xe0
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	ldur	x0, [x29, #0x10]
               	mov	x17, #0x3               // =3
               	mul	x1, x0, x17
               	add	x2, x0, #0xb
               	mov	x17, #0x7               // =7
               	mul	x3, x0, x17
               	sub	x4, x0, #0x2
               	mov	x17, #0xd               // =13
               	mul	x5, x0, x17
               	add	x6, x0, #0x1d
               	lsl	x7, x0, #2
               	add	x8, x0, #0x29
               	mov	x17, #0x9               // =9
               	mul	x9, x0, x17
               	add	x10, x0, #0x35
               	mov	x17, #0x5               // =5
               	mul	x11, x0, x17
               	add	x12, x0, #0x3d
               	mov	x17, #0xf               // =15
               	mul	x13, x0, x17
               	add	x0, x0, #0x3
               	sub	x14, x29, #0x20
               	add	x15, x29, #0x10
               	mov	x16, x14
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #0xffc8            // =65480
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x1c]
               	sub	x14, x29, #0x40
               	sub	x15, x29, #0x20
               	str	x9, [sp, #-0x10]!
               	ldr	x9, [x15]
               	str	x9, [x14]
               	ldr	x9, [x15, #0x8]
               	str	x9, [x14, #0x8]
               	ldr	x9, [x15, #0x10]
               	str	x9, [x14, #0x10]
               	ldr	x9, [x15, #0x18]
               	str	x9, [x14, #0x18]
               	ldr	x9, [sp], #0x10
               	sub	x14, x29, #0x40
               	mov	x17, x14
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x14, x16
               	ldr	x14, [x14]
               	sub	x15, x29, #0x40
               	mov	x17, x15
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x15, x16
               	ldr	x15, [x15]
               	sub	x20, x29, #0x40
               	sub	x20, x29, #0x20
               	add	x1, x1, x2
               	add	x1, x1, x3
               	add	x1, x1, x4
               	add	x1, x1, x5
               	add	x1, x1, x6
               	add	x1, x1, x7
               	add	x1, x1, x8
               	add	x1, x1, x9
               	add	x1, x1, x10
               	add	x1, x1, x11
               	add	x1, x1, x12
               	add	x1, x1, x13
               	add	x0, x1, x0
               	add	x0, x0, x14
               	add	x0, x0, x15
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x2                // =2
               	mov	x1, #0xa                // =10
               	mov	x2, #0x14               // =20
               	bl	<addr>
               	mov	x1, #0x160              // =352
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	ldp	x29, x30, [sp], #0x10
               	ret
