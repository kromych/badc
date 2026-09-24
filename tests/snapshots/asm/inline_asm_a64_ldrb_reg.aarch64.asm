
inline_asm_a64_ldrb_reg.aarch64:	file format elf64-littleaarch64

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
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	str	x16, [sp]
               	mov	x16, #0x3               // =3
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	ldrb	w0, [x1, x2]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
