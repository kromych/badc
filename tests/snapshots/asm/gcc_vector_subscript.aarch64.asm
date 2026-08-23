
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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x2, x29, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x3, #0xff               // =255
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	and	x5, x1, x3
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	mov	w1, w0
               	cmp	x1, #0x10
               	b.lo	<addr>
               	sub	x0, x29, #0x10
               	mov	x1, #0x63               // =99
               	strb	w1, [x0, #0x3]
               	mov	x1, #0xc8               // =200
               	strb	w1, [x0, #0xa]
               	ldrb	w1, [x0, #0x3]
               	mov	x17, #0x63              // =99
               	eor	x1, x1, x17
               	mov	w2, w1
               	cmp	x2, #0x0
               	cset	x1, ne
               	cbnz	x2, <addr>
               	ldrb	w0, [x0, #0xa]
               	mov	x17, #0xc8              // =200
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
