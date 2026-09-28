
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
               	sub	x3, x29, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w16, [x0]
               	str	w16, [x3]
               	ldrb	w16, [x0, #0x4]
               	strb	w16, [x3, #0x4]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldrb	w4, [x3, x0]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x2, x1
               	eor	x2, x4, x2
               	cbz	w2, <addr>
               	b	<addr>
               	mov	x2, #0x1                // =1
               	eor	x2, x4, x2
               	cbnz	w2, <addr>
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
