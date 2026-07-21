
inline_asm_a64_clobber.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x50
               	mov	x0, #0x13               // =19
               	mov	x1, #0xe                // =14
               	mov	x2, #0x9                // =9
               	sub	x3, x29, #0x20
               	sub	sp, sp, #0x50
               	str	x0, [sp, #0x20]
               	str	x1, [sp, #0x28]
               	str	x2, [sp, #0x30]
               	str	x3, [sp, #0x38]
               	str	x4, [sp, #0x40]
               	str	x3, [sp]
               	str	x0, [sp, #0x8]
               	str	x1, [sp, #0x10]
               	str	x2, [sp, #0x18]
               	ldr	x1, [sp, #0x8]
               	ldr	x3, [sp, #0x10]
               	ldr	x4, [sp, #0x18]
               	mov	x2, #0x0                // =0
               	add	w0, w1, w3
               	add	w0, w0, w4
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x20]
               	ldr	x1, [sp, #0x28]
               	ldr	x2, [sp, #0x30]
               	ldr	x3, [sp, #0x38]
               	ldr	x4, [sp, #0x40]
               	add	sp, sp, #0x50
               	ldursw	x0, [x29, #-0x20]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	mov	x1, #0xe                // =14
               	mov	x2, #0x8                // =8
               	scvtf	d0, x0
               	scvtf	d1, x1
               	scvtf	d2, x2
               	sub	x0, x29, #0x48
               	sub	sp, sp, #0x50
               	str	d0, [sp, #0x20]
               	str	d1, [sp, #0x28]
               	str	d2, [sp, #0x30]
               	str	d3, [sp, #0x38]
               	str	d4, [sp, #0x40]
               	str	x0, [sp]
               	str	d0, [sp, #0x8]
               	str	d1, [sp, #0x10]
               	str	d2, [sp, #0x18]
               	ldr	d2, [sp, #0x8]
               	ldr	d3, [sp, #0x10]
               	ldr	d4, [sp, #0x18]
               	fmov	d1, xzr
               	fadd	d0, d2, d3
               	fadd	d0, d0, d4
               	ldr	x16, [sp]
               	str	d0, [x16]
               	ldr	d0, [sp, #0x20]
               	ldr	d1, [sp, #0x28]
               	ldr	d2, [sp, #0x30]
               	ldr	d3, [sp, #0x38]
               	ldr	d4, [sp, #0x40]
               	add	sp, sp, #0x50
               	sub	x16, x29, #0x48
               	ldr	d0, [x16]
               	fcvtzs	x0, d0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
