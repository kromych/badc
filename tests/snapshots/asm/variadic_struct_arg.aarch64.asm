
variadic_struct_arg.aarch64:	file format elf64-littleaarch64

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
               	str	x19, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
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
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	sub	x2, x29, #0x20
               	mov	x17, x2
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
               	mov	x2, x16
               	sub	x4, x29, #0x38
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x4]
               	ldr	x10, [sp], #0x10
               	mov	x2, x4
               	sub	x2, x29, #0x38
               	ldrsw	x4, [x2]
               	sub	x2, x29, #0x38
               	ldrsw	x2, [x2, #0x4]
               	add	x2, x4, x2
               	add	x1, x1, x2
               	add	x0, x3, #0x1
               	sxtw	x3, w0
               	ldursw	x2, [x29, #0x10]
               	cmp	x3, x2
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp], #0x60
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x2                // =2
               	sub	x1, x29, #0x8
               	sub	x2, x29, #0x10
               	ldr	x1, [x1]
               	ldr	x2, [x2]
               	bl	<addr>
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
