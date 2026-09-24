
inline_struct_return_escape.aarch64:	file format elf64-littleaarch64

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

<mkesc>:
               	mov	x0, #0x2a               // =42
               	str	x0, [x1]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	xzr, [x29, #-0x8]
               	mov	x0, #0x2a               // =42
               	sub	x1, x29, #0x8
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x2a
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x2a
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
