
libc_div.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	sxtw	x1, w1
               	sub	x2, x29, #0x8
               	sdiv	x3, x0, x1
               	str	w3, [x2]
               	sub	x2, x29, #0x8
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	str	w0, [x2, #0x4]
               	sub	x0, x29, #0x8
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<ldiv>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x2, x29, #0x10
               	sdiv	x3, x0, x1
               	str	x3, [x2]
               	sub	x2, x29, #0x10
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	str	x0, [x2, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<lldiv>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x2, x29, #0x10
               	sdiv	x3, x0, x1
               	str	x3, [x2]
               	sub	x2, x29, #0x10
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	str	x0, [x2, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	mov	x0, #0x11               // =17
               	mov	x1, #0x5                // =5
               	sxtw	x0, w0
               	sxtw	x1, w1
               	sub	x2, x29, #0x78
               	sdiv	x3, x0, x1
               	str	w3, [x2]
               	sub	x2, x29, #0x78
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	str	w0, [x2, #0x4]
               	sub	x0, x29, #0x78
               	sub	x1, x29, #0x8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffef             // =65519
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x1, #0x5                // =5
               	sxtw	x0, w0
               	sxtw	x1, w1
               	sub	x2, x29, #0x88
               	sdiv	x3, x0, x1
               	str	w3, [x2]
               	sub	x2, x29, #0x88
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	str	w0, [x2, #0x4]
               	sub	x0, x29, #0x88
               	sub	x1, x29, #0x18
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x4]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0]
               	mov	x17, #0x5               // =5
               	mul	x0, x0, x17
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0x4]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	mov	x17, #0xffef            // =65519
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x64               // =100
               	mov	x1, #0x7                // =7
               	sub	x2, x29, #0xa0
               	sdiv	x3, x0, x1
               	str	x3, [x2]
               	sub	x2, x29, #0xa0
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	str	x0, [x2, #0x8]
               	sub	x0, x29, #0xa0
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x30
               	ldr	x0, [x0]
               	cmp	x0, #0xe
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x30
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3e8              // =1000
               	mov	x1, #0x3                // =3
               	sub	x2, x29, #0xb8
               	sdiv	x3, x0, x1
               	str	x3, [x2]
               	sub	x2, x29, #0xb8
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	str	x0, [x2, #0x8]
               	sub	x0, x29, #0xb8
               	sub	x1, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x50
               	ldr	x0, [x0]
               	cmp	x0, #0x14d
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x50
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
