
inline_asm_a64_ld1r.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	x0, #0x2a               // =42
               	stur	w0, [x29, #-0x10]
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x10
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	d0, [sp, #0x20]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	ld1r	{ v0.4s }, [x1]
               	mov	w0, v0.s[3]
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	ldr	d0, [sp, #0x20]
               	ldursw	x0, [x29, #-0x18]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x13               // =19
               	mov	x1, #0x17               // =23
               	sub	x2, x29, #0x18
               	mov	x3, #0x0                // =0
               	str	x3, [x2]
               	sub	x2, x29, #0x18
               	str	w0, [x2]
               	sub	x0, x29, #0x18
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x8
               	sub	x2, x29, #0x18
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	d0, [sp, #0x30]
               	str	d1, [sp, #0x38]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	ldr	x2, [sp, #0x10]
               	ld2r	{ v0.4s, v1.4s }, [x2]
               	mov	w0, v0.s[2]
               	mov	w1, v1.s[1]
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	w1, [x16]
               	ldr	x0, [sp, #0x18]
               	ldr	x1, [sp, #0x20]
               	ldr	x2, [sp, #0x28]
               	ldr	d0, [sp, #0x30]
               	ldr	d1, [sp, #0x38]
               	ldursw	x0, [x29, #-0x10]
               	ldursw	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
