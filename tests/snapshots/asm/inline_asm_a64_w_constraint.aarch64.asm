
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
               	sub	sp, sp, #0x30
               	mov	x1, #0x4045000000000000 // =4631107791820423168
               	sub	x0, x29, #0x8
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x0, [sp, #0x8]
               	fmov	d0, x0
               	ldr	x16, [sp]
               	str	d0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	d0, [sp, #0x8]
               	ldr	d0, [sp, #0x8]
               	fmov	x0, d0
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0x4045000000000000 // =4631107791820423168
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	sxtw	x0, w0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
