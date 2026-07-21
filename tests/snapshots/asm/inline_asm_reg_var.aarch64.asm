
inline_asm_reg_var.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x1e               // =30
               	mov	x1, #0xa                // =10
               	sub	x2, x29, #0x18
               	sub	sp, sp, #0x30
               	str	x0, [sp, #0x18]
               	str	x9, [sp, #0x20]
               	str	x12, [sp, #0x28]
               	str	x2, [sp]
               	str	x0, [sp, #0x8]
               	str	x1, [sp, #0x10]
               	ldr	x9, [sp, #0x8]
               	ldr	x12, [sp, #0x10]
               	add	x0, x9, x12
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x18]
               	ldr	x9, [sp, #0x20]
               	ldr	x12, [sp, #0x28]
               	add	sp, sp, #0x30
               	ldur	x0, [x29, #-0x18]
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<narrow_pinned>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x10
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	x9, [sp, #0x18]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x9, [sp, #0x8]
               	add	w0, w9, w9
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x9, [sp, #0x18]
               	add	sp, sp, #0x20
               	ldursw	x0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x1e               // =30
               	mov	x1, #0xa                // =10
               	sub	x2, x29, #0x18
               	sub	sp, sp, #0x30
               	str	x0, [sp, #0x18]
               	str	x9, [sp, #0x20]
               	str	x12, [sp, #0x28]
               	str	x2, [sp]
               	str	x0, [sp, #0x8]
               	str	x1, [sp, #0x10]
               	ldr	x9, [sp, #0x8]
               	ldr	x12, [sp, #0x10]
               	add	x0, x9, x12
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x18]
               	ldr	x9, [sp, #0x20]
               	ldr	x12, [sp, #0x28]
               	add	sp, sp, #0x30
               	ldur	x0, [x29, #-0x18]
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x28
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x28
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	x9, [sp, #0x18]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x9, [sp, #0x8]
               	add	w0, w9, w9
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x9, [sp, #0x18]
               	add	sp, sp, #0x20
               	ldursw	x0, [x29, #-0x28]
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
