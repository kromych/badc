
memcpy_basic.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	mov	x1, #0x41               // =65
               	strb	w1, [x20]
               	strb	w1, [x20, #0x1]
               	strb	w1, [x20, #0x2]
               	strb	w1, [x20, #0x3]
               	ldr	w16, [x20]
               	str	w16, [x0]
               	ldrb	w0, [x0]
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
