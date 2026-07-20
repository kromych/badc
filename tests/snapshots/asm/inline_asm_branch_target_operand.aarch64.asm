
inline_asm_branch_target_operand.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x1                // =1
               	ret

<helper_2>:
               	mov	x0, #0x2                // =2
               	ret

<helper_4>:
               	mov	x0, #0x4                // =4
               	ret

<helper_8>:
               	mov	x0, #0x8                // =8
               	ret

<by_size>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	mov	x1, #0x1                // =1
               	sub	sp, sp, #0x90
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x2, [sp, #0x20]
               	str	x3, [sp, #0x28]
               	str	x4, [sp, #0x30]
               	str	x5, [sp, #0x38]
               	str	x6, [sp, #0x40]
               	str	x7, [sp, #0x48]
               	str	x8, [sp, #0x50]
               	str	x9, [sp, #0x58]
               	str	x10, [sp, #0x60]
               	str	x11, [sp, #0x68]
               	str	x12, [sp, #0x70]
               	str	x13, [sp, #0x78]
               	str	x14, [sp, #0x80]
               	str	x15, [sp, #0x88]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	bl	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	ldr	x2, [sp, #0x20]
               	ldr	x3, [sp, #0x28]
               	ldr	x4, [sp, #0x30]
               	ldr	x5, [sp, #0x38]
               	ldr	x6, [sp, #0x40]
               	ldr	x7, [sp, #0x48]
               	ldr	x8, [sp, #0x50]
               	ldr	x9, [sp, #0x58]
               	ldr	x10, [sp, #0x60]
               	ldr	x11, [sp, #0x68]
               	ldr	x12, [sp, #0x70]
               	ldr	x13, [sp, #0x78]
               	ldr	x14, [sp, #0x80]
               	ldr	x15, [sp, #0x88]
               	add	sp, sp, #0x90
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x0
               	sub	x1, x29, #0x10
               	mov	x2, #0x2                // =2
               	sub	sp, sp, #0x90
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x2, [sp, #0x20]
               	str	x3, [sp, #0x28]
               	str	x4, [sp, #0x30]
               	str	x5, [sp, #0x38]
               	str	x6, [sp, #0x40]
               	str	x7, [sp, #0x48]
               	str	x8, [sp, #0x50]
               	str	x9, [sp, #0x58]
               	str	x10, [sp, #0x60]
               	str	x11, [sp, #0x68]
               	str	x12, [sp, #0x70]
               	str	x13, [sp, #0x78]
               	str	x14, [sp, #0x80]
               	str	x15, [sp, #0x88]
               	str	x1, [sp]
               	str	x2, [sp, #0x8]
               	bl	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	ldr	x2, [sp, #0x20]
               	ldr	x3, [sp, #0x28]
               	ldr	x4, [sp, #0x30]
               	ldr	x5, [sp, #0x38]
               	ldr	x6, [sp, #0x40]
               	ldr	x7, [sp, #0x48]
               	ldr	x8, [sp, #0x50]
               	ldr	x9, [sp, #0x58]
               	ldr	x10, [sp, #0x60]
               	ldr	x11, [sp, #0x68]
               	ldr	x12, [sp, #0x70]
               	ldr	x13, [sp, #0x78]
               	ldr	x14, [sp, #0x80]
               	ldr	x15, [sp, #0x88]
               	add	sp, sp, #0x90
               	ldursw	x1, [x29, #-0x10]
               	add	x0, x0, x1
               	sub	x1, x29, #0x10
               	mov	x2, #0x4                // =4
               	sub	sp, sp, #0x90
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x2, [sp, #0x20]
               	str	x3, [sp, #0x28]
               	str	x4, [sp, #0x30]
               	str	x5, [sp, #0x38]
               	str	x6, [sp, #0x40]
               	str	x7, [sp, #0x48]
               	str	x8, [sp, #0x50]
               	str	x9, [sp, #0x58]
               	str	x10, [sp, #0x60]
               	str	x11, [sp, #0x68]
               	str	x12, [sp, #0x70]
               	str	x13, [sp, #0x78]
               	str	x14, [sp, #0x80]
               	str	x15, [sp, #0x88]
               	str	x1, [sp]
               	str	x2, [sp, #0x8]
               	bl	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	ldr	x2, [sp, #0x20]
               	ldr	x3, [sp, #0x28]
               	ldr	x4, [sp, #0x30]
               	ldr	x5, [sp, #0x38]
               	ldr	x6, [sp, #0x40]
               	ldr	x7, [sp, #0x48]
               	ldr	x8, [sp, #0x50]
               	ldr	x9, [sp, #0x58]
               	ldr	x10, [sp, #0x60]
               	ldr	x11, [sp, #0x68]
               	ldr	x12, [sp, #0x70]
               	ldr	x13, [sp, #0x78]
               	ldr	x14, [sp, #0x80]
               	ldr	x15, [sp, #0x88]
               	add	sp, sp, #0x90
               	ldursw	x1, [x29, #-0x10]
               	add	x0, x0, x1
               	sub	x1, x29, #0x10
               	mov	x2, #0x8                // =8
               	sub	sp, sp, #0x90
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x2, [sp, #0x20]
               	str	x3, [sp, #0x28]
               	str	x4, [sp, #0x30]
               	str	x5, [sp, #0x38]
               	str	x6, [sp, #0x40]
               	str	x7, [sp, #0x48]
               	str	x8, [sp, #0x50]
               	str	x9, [sp, #0x58]
               	str	x10, [sp, #0x60]
               	str	x11, [sp, #0x68]
               	str	x12, [sp, #0x70]
               	str	x13, [sp, #0x78]
               	str	x14, [sp, #0x80]
               	str	x15, [sp, #0x88]
               	str	x1, [sp]
               	str	x2, [sp, #0x8]
               	bl	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	ldr	x2, [sp, #0x20]
               	ldr	x3, [sp, #0x28]
               	ldr	x4, [sp, #0x30]
               	ldr	x5, [sp, #0x38]
               	ldr	x6, [sp, #0x40]
               	ldr	x7, [sp, #0x48]
               	ldr	x8, [sp, #0x50]
               	ldr	x9, [sp, #0x58]
               	ldr	x10, [sp, #0x60]
               	ldr	x11, [sp, #0x68]
               	ldr	x12, [sp, #0x70]
               	ldr	x13, [sp, #0x78]
               	ldr	x14, [sp, #0x80]
               	ldr	x15, [sp, #0x88]
               	add	sp, sp, #0x90
               	ldursw	x1, [x29, #-0x10]
               	add	x0, x0, x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp], #0x10
               	ret
