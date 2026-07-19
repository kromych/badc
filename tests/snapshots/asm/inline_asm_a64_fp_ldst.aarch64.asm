
inline_asm_a64_fp_ldst.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x4045000000000000 // =4631107791820423168
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	stur	x0, [x29, #-0x18]
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x8
               	sub	x2, x29, #0x10
               	sub	sp, sp, #0x30
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	d0, [x1]
               	str	d0, [x2]
               	ldr	d0, [x2]
               	fmov	x0, d0
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x18]
               	ldr	x1, [sp, #0x20]
               	ldr	x2, [sp, #0x28]
               	add	sp, sp, #0x30
               	ldur	x0, [x29, #-0x18]
               	mov	x17, #0x4045000000000000 // =4631107791820423168
               	cmp	x0, x17
               	cset	x0, eq
               	cbz	x0, <addr>
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	mov	x0, #0x4045000000000000 // =4631107791820423168
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x2a               // =42
               	sxtw	x0, w0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
