
runtime_array_designator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<check>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x1, #0x7                // =7
               	mov	x2, #0x3                // =3
               	mov	x3, #0x5                // =5
               	sub	x0, x29, #0x18
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x0]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x4, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x18
               	str	w1, [x0, #0xc]
               	sub	x0, x29, #0x18
               	str	w2, [x0, #0x4]
               	sub	x0, x29, #0x18
               	str	w3, [x0, #0x8]
               	sub	x1, x29, #0x18
               	mov	x0, #0x0                // =0
               	ldrsw	x1, [x1]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x2, #0x1                // =1
               	mov	x0, #0x0                // =0
               	cbz	x2, <addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x14]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x7                // =7
               	mov	x1, #0x3                // =3
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
