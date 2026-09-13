
inline_asm_a64_fp_ldst.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x40
               	mov	x0, #0x4045000000000000 // =4631107791820423168
               	fmov	d16, x0
               	stur	d16, [x29, #-0x18]
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	stur	d16, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	sub	x16, x29, #0x18
               	str	x16, [sp, #0x8]
               	sub	x16, x29, #0x10
               	str	x16, [sp, #0x10]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	d0, [x1]
               	str	d0, [x2]
               	ldr	d0, [x2]
               	fmov	x0, d0
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0x4045000000000000 // =4631107791820423168
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	d0, [x29, #-0x10]
               	mov	x0, #0x4045000000000000 // =4631107791820423168
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x2a               // =42
               	sxtw	x0, w0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
