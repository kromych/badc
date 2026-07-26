
gcc_vector_subscript.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x28
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x28
               	ldrb	w0, [x0, #0x7]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x28
               	ldrb	w0, [x0, #0xf]
               	mov	x17, #0xf               // =15
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x28
               	mov	w1, w0
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	cmp	x2, x1
               	b.ne	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x10
               	b.lo	<addr>
               	sub	x0, x29, #0x28
               	mov	x1, #0x63               // =99
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x28
               	mov	x1, #0xc8               // =200
               	strb	w1, [x0, #0xa]
               	sub	x0, x29, #0x28
               	ldrb	w0, [x0, #0x3]
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x28
               	ldrb	w0, [x0, #0xa]
               	mov	x17, #0xc8              // =200
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x18
               	ldr	w0, [x0, #0x4]
               	mov	x17, #0x7d0             // =2000
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
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
               	mov	x17, #0x2710            // =10000
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x7530             // =30000
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x18
               	ldr	w0, [x0, #0x8]
               	mov	x17, #0x7530            // =30000
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x18
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
               	mov	x17, #0x9088            // =37000
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
