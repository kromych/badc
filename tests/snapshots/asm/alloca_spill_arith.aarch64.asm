
alloca_spill_arith.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	str	x19, [sp]
               	mov	x0, #0x10000            // =65536
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	mov	sp, x0
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	ldur	x0, [x29, #-0x10]
               	mov	x1, #0x2                // =2
               	strb	w1, [x0, #0x1]
               	ldur	x0, [x29, #-0x10]
               	mov	x1, #0x3                // =3
               	strb	w1, [x0, #0x2]
               	ldur	x0, [x29, #-0x10]
               	mov	x1, #0x4                // =4
               	strb	w1, [x0, #0x3]
               	ldur	x0, [x29, #-0x10]
               	mov	x1, #0x5                // =5
               	strb	w1, [x0, #0x4]
               	ldur	x0, [x29, #-0x10]
               	mov	x1, #0x6                // =6
               	strb	w1, [x0, #0x5]
               	ldur	x0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x8]
               	sub	x1, x1, #0x1
               	add	x0, x0, x1
               	mov	x1, #0x7                // =7
               	strb	w1, [x0]
               	ldur	x0, [x29, #-0x10]
               	ldrb	w1, [x0]
               	stur	x1, [x29, #-0x18]
               	ldrb	w1, [x0, #0x1]
               	stur	x1, [x29, #-0x20]
               	ldrb	w1, [x0, #0x2]
               	stur	x1, [x29, #-0x28]
               	ldrb	w1, [x0, #0x3]
               	stur	x1, [x29, #-0x30]
               	ldrb	w1, [x0, #0x4]
               	stur	x1, [x29, #-0x38]
               	ldrb	w0, [x0, #0x5]
               	stur	x0, [x29, #-0x40]
               	ldur	x0, [x29, #-0x18]
               	ldur	x1, [x29, #-0x20]
               	add	x0, x0, x1
               	stur	x0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x28]
               	ldur	x1, [x29, #-0x30]
               	add	x0, x0, x1
               	stur	x0, [x29, #-0x50]
               	ldur	x0, [x29, #-0x38]
               	ldur	x1, [x29, #-0x40]
               	add	x0, x0, x1
               	stur	x0, [x29, #-0x58]
               	ldur	x0, [x29, #-0x48]
               	mov	x17, #0x3               // =3
               	mul	x1, x0, x17
               	stur	x1, [x29, #-0x60]
               	ldur	x1, [x29, #-0x50]
               	mov	x17, #0x5               // =5
               	mul	x2, x1, x17
               	stur	x2, [x29, #-0x68]
               	ldur	x2, [x29, #-0x58]
               	mov	x17, #0x7               // =7
               	mul	x2, x2, x17
               	stur	x2, [x29, #-0x70]
               	cmp	x0, x1
               	b.ge	<addr>
               	ldur	x0, [x29, #-0x60]
               	stur	x0, [x29, #-0xc0]
               	ldur	x0, [x29, #-0xc0]
               	stur	x0, [x29, #-0x78]
               	ldur	x0, [x29, #-0x50]
               	ldur	x1, [x29, #-0x58]
               	cmp	x0, x1
               	b.ge	<addr>
               	ldur	x0, [x29, #-0x68]
               	stur	x0, [x29, #-0xc8]
               	ldur	x0, [x29, #-0xc8]
               	stur	x0, [x29, #-0x80]
               	ldur	x0, [x29, #-0x58]
               	ldur	x1, [x29, #-0x48]
               	cmp	x0, x1
               	b.ge	<addr>
               	ldur	x0, [x29, #-0x70]
               	stur	x0, [x29, #-0xd0]
               	ldur	x0, [x29, #-0xd0]
               	stur	x0, [x29, #-0x88]
               	ldur	x8, [x29, #-0x18]
               	ldur	x0, [x29, #-0x20]
               	add	x2, x8, x0
               	ldur	x1, [x29, #-0x28]
               	add	x3, x2, x1
               	ldur	x2, [x29, #-0x30]
               	add	x4, x3, x2
               	ldur	x3, [x29, #-0x38]
               	add	x4, x4, x3
               	ldur	x9, [x29, #-0x40]
               	add	x4, x4, x9
               	ldur	x10, [x29, #-0x48]
               	add	x5, x4, x10
               	ldur	x4, [x29, #-0x50]
               	add	x5, x5, x4
               	ldur	x11, [x29, #-0x58]
               	add	x6, x5, x11
               	ldur	x5, [x29, #-0x60]
               	add	x7, x6, x5
               	ldur	x6, [x29, #-0x68]
               	add	x12, x7, x6
               	ldur	x7, [x29, #-0x70]
               	add	x12, x12, x7
               	ldur	x13, [x29, #-0x78]
               	add	x12, x12, x13
               	ldur	x13, [x29, #-0x80]
               	add	x12, x12, x13
               	ldur	x13, [x29, #-0x88]
               	add	x12, x12, x13
               	stur	x12, [x29, #-0x90]
               	cmp	x8, x0
               	cset	x8, lt
               	cmp	x0, x1
               	cset	x0, lt
               	add	x0, x8, x0
               	cmp	x1, x2
               	cset	x1, lt
               	add	x0, x0, x1
               	cmp	x2, x3
               	cset	x1, lt
               	add	x0, x0, x1
               	cmp	x3, x9
               	cset	x1, lt
               	add	x0, x0, x1
               	cmp	x10, x4
               	cset	x1, gt
               	add	x0, x0, x1
               	cmp	x4, x11
               	cset	x1, gt
               	add	x0, x0, x1
               	cmp	x5, x6
               	cset	x1, ne
               	add	x0, x0, x1
               	cmp	x6, x7
               	cset	x1, ne
               	add	x0, x0, x1
               	cmp	x7, x5
               	cset	x1, ne
               	add	x0, x0, x1
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x98]
               	ldur	x0, [x29, #-0x90]
               	ldur	x1, [x29, #-0x98]
               	add	x0, x0, x1
               	stur	x0, [x29, #-0xa0]
               	ldur	x0, [x29, #-0x10]
               	mov	x1, #0x0                // =0
               	ldrb	w2, [x0]
               	ldur	x3, [x29, #-0x8]
               	sub	x3, x3, #0x1
               	add	x3, x0, x3
               	ldrb	w3, [x3]
               	add	x2, x2, x3
               	stur	x2, [x29, #-0xa8]
               	ldrb	w2, [x0, #0x2]
               	ldrb	w0, [x0, #0x3]
               	add	x0, x2, x0
               	stur	x0, [x29, #-0xb0]
               	ldur	x0, [x29, #-0xa0]
               	cmp	x0, #0xe0
               	cset	x0, eq
               	stur	x1, [x29, #-0xe0]
               	cbz	x0, <addr>
               	ldur	x0, [x29, #-0xa8]
               	cmp	x0, #0x8
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0xe0]
               	ldur	x0, [x29, #-0xe0]
               	stur	x0, [x29, #-0xd8]
               	cbz	x0, <addr>
               	ldur	x0, [x29, #-0xb0]
               	cmp	x0, #0x7
               	cset	x0, eq
               	stur	x0, [x29, #-0xd8]
               	ldur	x0, [x29, #-0xd8]
               	cbz	x0, <addr>
               	mov	x0, #0x2a               // =42
               	stur	x0, [x29, #-0xe8]
               	ldur	x0, [x29, #-0xe8]
               	sxtw	x0, w0
               	sub	sp, x29, #0x100
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0xe8]
               	b	<addr>
               	ldur	x0, [x29, #-0x60]
               	stur	x0, [x29, #-0xd0]
               	b	<addr>
               	ldur	x0, [x29, #-0x70]
               	stur	x0, [x29, #-0xc8]
               	b	<addr>
               	ldur	x0, [x29, #-0x68]
               	stur	x0, [x29, #-0xc0]
               	b	<addr>
