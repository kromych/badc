
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

<identity>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	q0, [x16]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	sub	x0, x29, #0x90
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	q0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x20
               	str	q0, [x16]
               	sub	x0, x29, #0x20
               	ldrb	w1, [x0]
               	ldrb	w2, [x0, #0x7]
               	ldrb	w3, [x0, #0xf]
               	eor	x0, x1, #0x1
               	cbnz	x0, <addr>
               	eor	x0, x2, #0x8
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	eor	x0, x3, #0x10
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x90
               	ldrb	w1, [x0]
               	ldrb	w2, [x0, #0xf]
               	eor	x0, x1, #0x1
               	cbnz	x0, <addr>
               	eor	x0, x2, #0x10
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
