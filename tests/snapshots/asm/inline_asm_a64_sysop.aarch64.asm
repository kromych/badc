
inline_asm_a64_sysop.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x2a               // =42
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	dc	cvac, x0
               	ldr	x0, [sp, #0x8]
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
