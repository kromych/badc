
gcc_vector_size_attribute.aarch64:	file format elf64-littleaarch64

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
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	q0, [x0]
               	sub	x0, x29, #0x10
               	str	q0, [x0]
               	ldrb	w1, [x0]
               	eor	x1, x1, #0x1
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x7]
               	eor	x1, x1, #0x8
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0xf]
               	eor	x0, x0, #0x10
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
