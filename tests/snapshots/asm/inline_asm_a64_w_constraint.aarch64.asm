
inline_asm_a64_w_constraint.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	mov	x16, #0x4045000000000000 // =4631107791820423168
               	str	x16, [sp, #0x8]
               	ldr	x0, [sp, #0x8]
               	fmov	d0, x0
               	ldr	x16, [sp]
               	str	d0, [x16]
               	ldur	d0, [x29, #-0x8]
               	str	d0, [sp]
               	ldr	d0, [sp]
               	fmov	x0, d0
               	mov	x17, #0x4045000000000000 // =4631107791820423168
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
