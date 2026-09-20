
inline_asm_a64_fp_cvt.aarch64:	file format elf64-littleaarch64

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
               	mov	x16, #0x2a              // =42
               	str	x16, [sp, #0x8]
               	ldr	x0, [sp, #0x8]
               	scvtf	d0, x0
               	ldr	x16, [sp]
               	str	d0, [x16]
               	ldur	d0, [x29, #-0x8]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	str	d0, [sp, #0x8]
               	ldr	d0, [sp, #0x8]
               	fcvtzs	x0, d0
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
