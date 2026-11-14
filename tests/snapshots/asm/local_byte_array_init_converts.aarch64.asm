
local_byte_array_init_converts.aarch64:	file format elf64-littleaarch64

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
               	sub	x2, x29, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w16, [x0]
               	str	w16, [x2]
               	ldrb	w16, [x0, #0x4]
               	strb	w16, [x2, #0x4]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldrb	w3, [x2, x0]
               	mov	x4, #0x1                // =1
               	cmp	w0, #0x1
               	csel	x4, x1, x4, eq
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
