
inline_asm_a64_fp_immediate.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x8]
               	str	d0, [sp, #0x10]
               	str	x0, [sp]
               	fmov	d0, #2.00000000
               	fmov	x0, d0
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x8]
               	ldr	d0, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x8]
               	str	d0, [sp, #0x10]
               	str	x0, [sp]
               	fmov	v0.4s, #1.00000000
               	mov	w0, v0.s[2]
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x8]
               	ldr	d0, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldursw	x0, [x29, #-0x10]
               	mov	x17, #0x3f800000        // =1065353216
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
