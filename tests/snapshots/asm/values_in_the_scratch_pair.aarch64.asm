
values_in_the_scratch_pair.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<mix>:
               	eor	x0, x0, x1, lsr #3
               	mov	x17, #0x7c15            // =31765
               	movk	x17, #0x7f4a, lsl #16
               	movk	x17, #0x79b9, lsl #32
               	movk	x17, #0x9e37, lsl #48
               	mul	x0, x0, x17
               	ret

<direct>:
               	stp	x20, x21, [sp, #-0xb0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	mov	x21, #0x0               // =0
               	ldr	x27, [x1]
               	ldr	x26, [x1, #0x8]
               	ldr	x25, [x1, #0x10]
               	ldr	x20, [x1, #0x18]
               	ldr	x3, [x1, #0x20]
               	ldr	x24, [x1, #0x28]
               	ldr	x23, [x1, #0x30]
               	ldr	x22, [x1, #0x38]
               	ldr	x10, [x1, #0x40]
               	ldr	x9, [x1, #0x48]
               	ldr	x8, [x1, #0x50]
               	ldr	x4, [x1, #0x58]
               	ldr	x7, [x1, #0x60]
               	ldr	x6, [x1, #0x68]
               	ldr	x5, [x1, #0x70]
               	ldr	x1, [x1, #0x78]
               	str	x0, [sp, #0x98]
               	str	x2, [sp, #0x90]
               	b	<addr>
               	add	x3, x24, x7
               	eor	x24, x23, x6
               	add	x23, x22, x5
               	eor	x22, x10, x1
               	add	x10, x9, x27
               	eor	x9, x8, x26
               	add	x8, x4, x25
               	eor	x4, x7, x20
               	add	x7, x6, x3
               	eor	x6, x5, x24
               	add	x5, x1, x23
               	eor	x1, x28, x22
               	add	x21, x21, #0x1
               	cmp	x21, x2
               	b.ge	<addr>
               	mov	x17, #0x7c15            // =31765
               	movk	x17, #0x7f4a, lsl #16
               	movk	x17, #0x79b9, lsl #32
               	movk	x17, #0x9e37, lsl #48
               	mul	x28, x27, x17
               	and	x11, x20, #0x3f
               	lsr	x11, x25, x11
               	add	x27, x26, x11
               	orr	x12, x3, #0x1
               	udiv	x11, x28, x12
               	eor	x26, x25, x11
               	cmp	x24, x23
               	csel	x11, x22, x10, lo
               	add	x25, x20, x11
               	and	x11, x21, #0x7
               	add	x13, x9, x8
               	str	x13, [x0, x11, lsl #3]
               	and	x11, x21, #0x3
               	cmp	w11, #0x1
               	b.lt	<addr>
               	cmp	w11, #0x2
               	b.lt	<addr>
               	cmp	w11, #0x2
               	b.eq	<addr>
               	mul	x20, x12, x4
               	and	x3, x21, #0xf
               	cbnz	w3, <addr>
               	str	x1, [sp, #0x88]
               	str	x5, [sp, #0x80]
               	str	x6, [sp, #0x78]
               	str	x7, [sp, #0x70]
               	str	x4, [sp, #0x68]
               	str	x8, [sp, #0x60]
               	str	x9, [sp, #0x58]
               	str	x10, [sp, #0x50]
               	mov	x0, x27
               	mov	x1, x26
               	bl	<addr>
               	mov	x3, x0
               	ldr	x0, [sp, #0x98]
               	ldr	x2, [sp, #0x90]
               	ldr	x1, [sp, #0x88]
               	ldr	x5, [sp, #0x80]
               	ldr	x6, [sp, #0x78]
               	ldr	x7, [sp, #0x70]
               	ldr	x4, [sp, #0x68]
               	ldr	x8, [sp, #0x60]
               	ldr	x9, [sp, #0x58]
               	ldr	x10, [sp, #0x50]
               	eor	x28, x28, x3
               	b	<addr>
               	sub	x20, x3, x4
               	b	<addr>
               	add	x20, x3, x4, lsl #3
               	b	<addr>
               	eor	x20, x3, x4
               	b	<addr>
               	eor	x0, x27, x26
               	eor	x0, x0, x25
               	eor	x0, x0, x20
               	eor	x0, x0, x3
               	eor	x0, x0, x24
               	eor	x0, x0, x23
               	eor	x0, x0, x22
               	eor	x0, x0, x10
               	eor	x0, x0, x9
               	eor	x0, x0, x8
               	eor	x0, x0, x4
               	eor	x0, x0, x7
               	eor	x0, x0, x6
               	eor	x0, x0, x5
               	eor	x0, x0, x1
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret

<in_memory>:
               	stp	x20, x21, [sp, #-0xb0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	mov	x22, x0
               	mov	x23, x2
               	mov	x3, #0x0                // =0
               	sub	x0, x29, #0x80
               	lsl	x4, x3, #3
               	add	x0, x0, x4
               	add	x2, x1, x4
               	ldr	x2, [x2]
               	str	x2, [x0]
               	add	x3, x3, #0x1
               	cmp	w3, #0x10
               	b.lt	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	ldur	x1, [x29, #-0x20]
               	add	x0, x0, x1
               	stur	x0, [x29, #-0x60]
               	ldur	x0, [x29, #-0x50]
               	ldur	x1, [x29, #-0x18]
               	eor	x0, x0, x1
               	stur	x0, [x29, #-0x58]
               	ldur	x0, [x29, #-0x48]
               	ldur	x1, [x29, #-0x10]
               	add	x0, x0, x1
               	stur	x0, [x29, #-0x50]
               	ldur	x0, [x29, #-0x40]
               	ldur	x1, [x29, #-0x8]
               	eor	x0, x0, x1
               	stur	x0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x38]
               	ldur	x1, [x29, #-0x80]
               	add	x0, x0, x1
               	stur	x0, [x29, #-0x40]
               	ldur	x0, [x29, #-0x30]
               	ldur	x1, [x29, #-0x78]
               	eor	x0, x0, x1
               	stur	x0, [x29, #-0x38]
               	ldur	x0, [x29, #-0x28]
               	ldur	x1, [x29, #-0x70]
               	add	x0, x0, x1
               	stur	x0, [x29, #-0x30]
               	ldur	x0, [x29, #-0x20]
               	ldur	x1, [x29, #-0x68]
               	eor	x0, x0, x1
               	stur	x0, [x29, #-0x28]
               	ldur	x0, [x29, #-0x18]
               	ldur	x1, [x29, #-0x60]
               	add	x0, x0, x1
               	stur	x0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x58]
               	eor	x0, x0, x1
               	stur	x0, [x29, #-0x18]
               	ldur	x0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x50]
               	add	x0, x0, x1
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x48]
               	eor	x0, x21, x0
               	stur	x0, [x29, #-0x8]
               	add	x20, x20, #0x1
               	cmp	x20, x23
               	b.ge	<addr>
               	ldur	x0, [x29, #-0x80]
               	mov	x17, #0x7c15            // =31765
               	movk	x17, #0x7f4a, lsl #16
               	movk	x17, #0x79b9, lsl #32
               	movk	x17, #0x9e37, lsl #48
               	mul	x21, x0, x17
               	ldur	x0, [x29, #-0x78]
               	ldur	x1, [x29, #-0x70]
               	ldur	x2, [x29, #-0x68]
               	and	x2, x2, #0x3f
               	lsr	x1, x1, x2
               	add	x0, x0, x1
               	stur	x0, [x29, #-0x80]
               	ldur	x0, [x29, #-0x70]
               	ldur	x1, [x29, #-0x60]
               	orr	x1, x1, #0x1
               	udiv	x1, x21, x1
               	eor	x0, x0, x1
               	stur	x0, [x29, #-0x78]
               	ldur	x0, [x29, #-0x68]
               	ldur	x1, [x29, #-0x58]
               	ldur	x2, [x29, #-0x50]
               	cmp	x1, x2
               	b.hs	<addr>
               	ldur	x1, [x29, #-0x48]
               	add	x0, x0, x1
               	stur	x0, [x29, #-0x70]
               	and	x0, x20, #0x7
               	ldur	x1, [x29, #-0x38]
               	ldur	x2, [x29, #-0x30]
               	add	x1, x1, x2
               	str	x1, [x22, x0, lsl #3]
               	and	x1, x20, #0x3
               	cmp	w1, #0x1
               	b.lt	<addr>
               	cmp	w1, #0x2
               	b.lt	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	ldur	x0, [x29, #-0x60]
               	orr	x0, x0, #0x1
               	ldur	x1, [x29, #-0x28]
               	mul	x0, x0, x1
               	stur	x0, [x29, #-0x68]
               	and	x0, x20, #0xf
               	cbnz	w0, <addr>
               	ldur	x0, [x29, #-0x80]
               	ldur	x1, [x29, #-0x78]
               	bl	<addr>
               	eor	x21, x21, x0
               	b	<addr>
               	ldur	x0, [x29, #-0x60]
               	ldur	x1, [x29, #-0x28]
               	sub	x0, x0, x1
               	stur	x0, [x29, #-0x68]
               	b	<addr>
               	ldur	x0, [x29, #-0x60]
               	ldur	x1, [x29, #-0x28]
               	add	x0, x0, x1, lsl #3
               	stur	x0, [x29, #-0x68]
               	b	<addr>
               	ldur	x0, [x29, #-0x60]
               	ldur	x1, [x29, #-0x28]
               	eor	x0, x0, x1
               	stur	x0, [x29, #-0x68]
               	b	<addr>
               	ldur	x1, [x29, #-0x40]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	sub	x2, x29, #0x80
               	add	x2, x2, x0, lsl #3
               	ldr	x2, [x2]
               	eor	x1, x1, x2
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x170]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x160]
               	add	x29, sp, #0x160
               	mov	x0, #0x0                // =0
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	stur	x0, [x29, #-0x80]
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	movk	x0, #0x4567, lsl #32
               	movk	x0, #0x123, lsl #48
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	stur	x0, [x29, #-0x78]
               	mov	x0, #0x9bde             // =39902
               	movk	x0, #0x1357, lsl #16
               	movk	x0, #0x8acf, lsl #32
               	movk	x0, #0x246, lsl #48
               	mov	x1, #0x9                // =9
               	bl	<addr>
               	stur	x0, [x29, #-0x70]
               	mov	x0, #0x69cd             // =27085
               	movk	x0, #0x9d03, lsl #16
               	movk	x0, #0xd036, lsl #32
               	movk	x0, #0x369, lsl #48
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	stur	x0, [x29, #-0x68]
               	mov	x0, #0x37bc             // =14268
               	movk	x0, #0x26af, lsl #16
               	movk	x0, #0x159e, lsl #32
               	movk	x0, #0x48d, lsl #48
               	mov	x1, #0xb                // =11
               	bl	<addr>
               	stur	x0, [x29, #-0x60]
               	mov	x0, #0x5ab              // =1451
               	movk	x0, #0xb05b, lsl #16
               	movk	x0, #0x5b05, lsl #32
               	movk	x0, #0x5b0, lsl #48
               	mov	x1, #0xc                // =12
               	bl	<addr>
               	stur	x0, [x29, #-0x58]
               	mov	x0, #0xd39a             // =54170
               	movk	x0, #0x3a06, lsl #16
               	movk	x0, #0xa06d, lsl #32
               	movk	x0, #0x6d3, lsl #48
               	mov	x1, #0xd                // =13
               	bl	<addr>
               	stur	x0, [x29, #-0x50]
               	mov	x0, #0xa189             // =41353
               	movk	x0, #0xc3b2, lsl #16
               	movk	x0, #0xe5d4, lsl #32
               	movk	x0, #0x7f6, lsl #48
               	mov	x1, #0xe                // =14
               	bl	<addr>
               	stur	x0, [x29, #-0x48]
               	mov	x0, #0x6f78             // =28536
               	movk	x0, #0x4d5e, lsl #16
               	movk	x0, #0x2b3c, lsl #32
               	movk	x0, #0x91a, lsl #48
               	mov	x1, #0xf                // =15
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	mov	x0, #0x3d67             // =15719
               	movk	x0, #0xd70a, lsl #16
               	movk	x0, #0x70a3, lsl #32
               	movk	x0, #0xa3d, lsl #48
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	stur	x0, [x29, #-0x38]
               	mov	x0, #0xb56              // =2902
               	movk	x0, #0x60b6, lsl #16
               	movk	x0, #0xb60b, lsl #32
               	movk	x0, #0xb60, lsl #48
               	mov	x1, #0x11               // =17
               	bl	<addr>
               	stur	x0, [x29, #-0x30]
               	mov	x0, #0xd945             // =55621
               	movk	x0, #0xea61, lsl #16
               	movk	x0, #0xfb72, lsl #32
               	movk	x0, #0xc83, lsl #48
               	mov	x1, #0x12               // =18
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	mov	x0, #0xa734             // =42804
               	movk	x0, #0x740d, lsl #16
               	movk	x0, #0x40da, lsl #32
               	movk	x0, #0xda7, lsl #48
               	mov	x1, #0x13               // =19
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	mov	x0, #0x7523             // =29987
               	movk	x0, #0xfdb9, lsl #16
               	movk	x0, #0x8641, lsl #32
               	movk	x0, #0xeca, lsl #48
               	mov	x1, #0x14               // =20
               	bl	<addr>
               	stur	x0, [x29, #-0x18]
               	mov	x0, #0x4312             // =17170
               	movk	x0, #0x8765, lsl #16
               	movk	x0, #0xcba9, lsl #32
               	movk	x0, #0xfed, lsl #48
               	mov	x1, #0x15               // =21
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x23, x29, #0x80
               	mov	x0, #0x1101             // =4353
               	movk	x0, #0x1111, lsl #16
               	movk	x0, #0x1111, lsl #32
               	movk	x0, #0x1111, lsl #48
               	mov	x1, #0x16               // =22
               	bl	<addr>
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x100
               	stp	xzr, xzr, [x22]
               	stp	xzr, xzr, [x22, #0x10]
               	stp	xzr, xzr, [x22, #0x20]
               	stp	xzr, xzr, [x22, #0x30]
               	sub	x0, x29, #0xc0
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	sub	x0, x29, #0x130
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	mov	x20, #0x0               // =0
               	sub	x21, x29, #0x130
               	ldr	x2, [x21, x20, lsl #3]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	mov	x24, x0
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0x80
               	ldr	x2, [x21, x20, lsl #3]
               	bl	<addr>
               	cmp	x24, x0
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x100]
               	ldur	x1, [x29, #-0xc0]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xf8]
               	ldur	x1, [x29, #-0xb8]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xf0]
               	ldur	x1, [x29, #-0xb0]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xe8]
               	ldur	x1, [x29, #-0xa8]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xe0]
               	ldur	x1, [x29, #-0xa0]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xd8]
               	ldur	x1, [x29, #-0x98]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xd0]
               	ldur	x1, [x29, #-0x90]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xc8]
               	ldur	x1, [x29, #-0x88]
               	cmp	x0, x1
               	b.ne	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x6
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x160]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x170
               	ret
               	add	x0, x20, #0xa
               	ldp	x29, x30, [sp, #0x160]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x170
               	ret
               	add	x0, x20, #0x1
               	ldp	x29, x30, [sp, #0x160]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x170
               	ret
