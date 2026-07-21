
inline_asm_a64_reduce.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	mov	x0, #0xa                // =10
               	mov	x1, #0xc                // =12
               	mov	x2, #0xb                // =11
               	mov	x3, #0x9                // =9
               	sub	x4, x29, #0x28
               	sub	sp, sp, #0x60
               	str	x0, [sp, #0x28]
               	str	x1, [sp, #0x30]
               	str	x2, [sp, #0x38]
               	str	x3, [sp, #0x40]
               	str	x4, [sp, #0x48]
               	str	d0, [sp, #0x50]
               	str	x4, [sp]
               	str	x0, [sp, #0x8]
               	str	x1, [sp, #0x10]
               	str	x2, [sp, #0x18]
               	str	x3, [sp, #0x20]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	ldr	x4, [sp, #0x20]
               	mov	v0.s[0], w1
               	mov	v0.s[1], w2
               	mov	v0.s[2], w3
               	mov	v0.s[3], w4
               	addv	s0, v0.4s
               	mov	w0, v0.s[0]
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x28]
               	ldr	x1, [sp, #0x30]
               	ldr	x2, [sp, #0x38]
               	ldr	x3, [sp, #0x40]
               	ldr	x4, [sp, #0x48]
               	ldr	d0, [sp, #0x50]
               	add	sp, sp, #0x60
               	ldursw	x0, [x29, #-0x28]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	sub	x1, x29, #0x30
               	sub	sp, sp, #0x30
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	d0, [sp, #0x20]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	dup	v0.16b, w1
               	saddlv	h0, v0.16b
               	umov	w0, v0.h[0]
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	ldr	d0, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldursw	x0, [x29, #-0x30]
               	cmp	x0, #0x20
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
