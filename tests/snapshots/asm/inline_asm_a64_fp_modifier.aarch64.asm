
inline_asm_a64_fp_modifier.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x16, #0x4018000000000000 // =4618441417868443648
               	str	x16, [sp]
               	mov	x16, #0x401c000000000000 // =4619567317775286272
               	str	x16, [sp, #0x8]
               	ldr	d1, [sp]
               	ldr	d2, [sp, #0x8]
               	fmul	d0, d1, d2
               	mov	x16, #0x4045000000000000 // =4631107791820423168
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
