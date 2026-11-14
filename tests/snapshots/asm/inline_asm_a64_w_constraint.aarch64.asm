
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
               	mov	x16, #0x4045000000000000 // =4631107791820423168
               	fmov	d0, x16
               	fmov	x0, d0
               	mov	x1, #0x2a               // =42
               	mov	x2, #0x0                // =0
               	mov	x17, #0x4045000000000000 // =4631107791820423168
               	cmp	x0, x17
               	csel	x0, x1, x2, eq
               	ret
