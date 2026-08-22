
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
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x21, x29, #0x30
               	mov	x20, #0x0               // =0
               	str	x20, [x21]
               	str	x20, [x21, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	ldrb	w0, [x1]
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w2, w0
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	ldrb	w0, [x1, #0x7]
               	mov	x17, #0x8               // =8
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x1, #0xf]
               	mov	x17, #0x10              // =16
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	b	<addr>
               	sxtw	x0, w20
               	add	x1, x21, x0
               	ldrb	w1, [x1]
               	cbnz	x1, <addr>
               	add	x20, x0, #0x1
               	cmp	w20, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x40
               	sub	x0, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	ldrb	w1, [x0]
               	mov	x17, #0x1               // =1
               	eor	x1, x1, x17
               	mov	w2, w1
               	cmp	w2, #0x0
               	cset	x1, ne
               	cbnz	x2, <addr>
               	ldrb	w1, [x0, #0xf]
               	mov	x17, #0x10              // =16
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	mov	x2, x1
               	sub	x2, x29, #0x20
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x2
               	mov	x3, x1
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	ldrb	w2, [x0]
               	mov	x17, #0x9               // =9
               	eor	x2, x2, x17
               	mov	w3, w2
               	cmp	w3, #0x0
               	cset	x2, ne
               	cbnz	x3, <addr>
               	ldrb	w0, [x0, #0xf]
               	mov	x17, #0xa               // =10
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	b	<addr>
               	b	<addr>
