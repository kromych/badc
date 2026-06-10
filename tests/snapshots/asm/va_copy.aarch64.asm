
va_copy.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x60
               	str	x19, [sp]
               	sub	x0, x29, #0x20
               	add	x1, x29, #0x10
               	mov	x16, x0
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
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0x20
               	str	x9, [sp, #-0x10]!
               	ldr	x9, [x1]
               	str	x9, [x0]
               	ldr	x9, [x1, #0x8]
               	str	x9, [x0, #0x8]
               	ldr	x9, [x1, #0x10]
               	str	x9, [x0, #0x10]
               	ldr	x9, [x1, #0x18]
               	str	x9, [x0, #0x18]
               	ldr	x9, [sp], #0x10
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	sxtw	x2, w1
               	ldursw	x3, [x29, #0x10]
               	cmp	x2, x3
               	b.ge	<addr>
               	sxtw	x0, w0
               	sub	x2, x29, #0x40
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldrsw	x2, [x2]
               	add	x0, x0, x2
               	sxtw	x0, w0
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	b	<addr>
               	sub	x1, x29, #0x40
               	sub	x1, x29, #0x20
               	sxtw	x0, w0
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x4                // =4
               	mov	x1, #0xa                // =10
               	mov	x2, #0x14               // =20
               	mov	x3, #0x1e               // =30
               	mov	x4, #0x28               // =40
               	bl	<addr>
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
