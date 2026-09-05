
gcc_vector_subscript.aarch64:	file format elf64-littleaarch64

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

<sum4>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	q0, [x16]
               	sub	x0, x29, #0x20
               	add	x1, x0, #0x0
               	ldr	w1, [x1]
               	add	x1, x1, #0x0
               	mov	w1, w1
               	ldr	w2, [x0, #0x4]
               	add	x1, x1, x2
               	mov	w1, w1
               	ldr	w2, [x0, #0x8]
               	add	x1, x1, x2
               	mov	w1, w1
               	ldr	w0, [x0, #0xc]
               	add	x0, x1, x0
               	mov	w0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	ldr	q0, [x0]
               	bl	<addr>
               	mov	x17, #0x2710            // =10000
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	mov	x1, #0x7530             // =30000
               	str	w1, [x0, #0x8]
               	ldr	w1, [x0, #0x8]
               	mov	x17, #0x7530            // =30000
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbnz	x1, <addr>
               	ldr	q0, [x0]
               	bl	<addr>
               	mov	x17, #0x9088            // =37000
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
