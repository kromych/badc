
int128_mul.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x30
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x4
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	cmp	x0, x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0, #0x8]
               	mov	x4, #0x0                // =0
               	sub	x0, x29, #0x28
               	str	x1, [x0]
               	str	x4, [x0, #0x8]
               	cmp	x1, x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	sxtw	x0, w3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	b	<addr>

<mulhi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x2, x1
               	sub	x1, x29, #0x10
               	str	x0, [x1]
               	mov	x3, #0x0                // =0
               	str	x3, [x1, #0x8]
               	mul	x7, x0, x2
               	mov	w1, w0
               	lsr	x4, x0, #32
               	mov	w5, w2
               	lsr	x6, x2, #32
               	mul	x8, x1, x5
               	lsr	x8, x8, #32
               	mul	x5, x4, x5
               	add	x5, x5, x8
               	mov	w8, w5
               	lsr	x5, x5, #32
               	mul	x1, x1, x6
               	add	x1, x1, x8
               	lsr	x1, x1, #32
               	mul	x4, x4, x6
               	add	x4, x4, x5
               	add	x1, x4, x1
               	mul	x0, x0, x3
               	mul	x2, x3, x2
               	add	x0, x1, x0
               	add	x1, x0, x2
               	sub	x0, x29, #0x20
               	str	x7, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x30
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	mov	x0, x1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x1b0]!
               	stp	x29, x30, [sp, #0x1a0]
               	add	x29, sp, #0x1a0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x21, [x0]
               	sub	x0, x29, #0x98
               	str	x20, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	mul	x5, x20, x21
               	mov	w0, w20
               	lsr	x2, x20, #32
               	mov	w3, w21
               	lsr	x4, x21, #32
               	mul	x6, x0, x3
               	lsr	x6, x6, #32
               	mul	x3, x2, x3
               	add	x3, x3, x6
               	mov	w6, w3
               	lsr	x3, x3, #32
               	mul	x0, x0, x4
               	add	x0, x0, x6
               	lsr	x0, x0, #32
               	mul	x2, x2, x4
               	add	x2, x2, x3
               	add	x0, x2, x0
               	mul	x2, x20, x1
               	mul	x1, x1, x21
               	add	x0, x0, x2
               	add	x1, x0, x1
               	sub	x0, x29, #0xa8
               	str	x5, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x28
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x28
               	mov	x1, #0x5d10             // =23824
               	movk	x1, #0x4bb, lsl #16
               	movk	x1, #0x45c, lsl #32
               	movk	x1, #0xe5cf, lsl #48
               	mov	x2, #0x3a3b             // =14907
               	movk	x2, #0x9b83, lsl #16
               	movk	x2, #0x6474, lsl #32
               	movk	x2, #0xddbf, lsl #48
               	mov	x3, #0x1                // =1
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1a0]
               	ldp	x20, x21, [sp], #0x1b0
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0x3a3b            // =14907
               	movk	x17, #0x9b83, lsl #16
               	movk	x17, #0x6474, lsl #32
               	movk	x17, #0xddbf, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x1a0]
               	ldp	x20, x21, [sp], #0x1b0
               	ret
               	sub	x0, x29, #0xb8
               	str	x20, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	mul	x2, x20, x21
               	mov	w0, w20
               	lsr	x3, x20, #32
               	mov	w4, w21
               	lsr	x5, x21, #32
               	mul	x6, x0, x4
               	lsr	x6, x6, #32
               	mul	x4, x3, x4
               	add	x4, x4, x6
               	mov	w6, w4
               	lsr	x4, x4, #32
               	mul	x0, x0, x5
               	add	x0, x0, x6
               	lsr	x0, x0, #32
               	mul	x3, x3, x5
               	add	x3, x3, x4
               	add	x0, x3, x0
               	mul	x3, x20, x1
               	mul	x1, x1, x21
               	add	x0, x0, x3
               	add	x1, x0, x1
               	sub	x0, x29, #0xc8
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	mul	x0, x20, x21
               	cmp	x2, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x1a0]
               	ldp	x20, x21, [sp], #0x1b0
               	ret
               	sub	x1, x29, #0x28
               	ldr	x0, [x1]
               	ldr	x6, [x1, #0x8]
               	sub	x2, x29, #0x28
               	ldr	x1, [x2]
               	ldr	x7, [x2, #0x8]
               	mul	x8, x0, x1
               	mov	w2, w0
               	lsr	x3, x0, #32
               	mov	w4, w1
               	lsr	x5, x1, #32
               	mul	x9, x2, x4
               	lsr	x9, x9, #32
               	mul	x4, x3, x4
               	add	x4, x4, x9
               	mov	w9, w4
               	lsr	x4, x4, #32
               	mul	x2, x2, x5
               	add	x2, x2, x9
               	lsr	x2, x2, #32
               	mul	x3, x3, x5
               	add	x3, x3, x4
               	add	x2, x3, x2
               	mul	x0, x0, x7
               	mul	x1, x6, x1
               	add	x0, x2, x0
               	add	x1, x0, x1
               	sub	x0, x29, #0xd8
               	str	x8, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x38
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x38
               	mov	x1, #0xa100             // =41216
               	movk	x1, #0x9734, lsl #16
               	movk	x1, #0xc789, lsl #32
               	movk	x1, #0x6189, lsl #48
               	mov	x2, #0x218              // =536
               	movk	x2, #0x6042, lsl #16
               	movk	x2, #0x4ab6, lsl #32
               	movk	x2, #0x95fa, lsl #48
               	mov	x3, #0x4                // =4
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1a0]
               	ldp	x20, x21, [sp], #0x1b0
               	ret
               	mov	x0, #0xfffb             // =65531
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sub	x1, x29, #0xe8
               	str	x0, [x1]
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	str	x3, [x1, #0x8]
               	mov	x1, #0xfff9             // =65529
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	sub	x2, x29, #0xf8
               	str	x1, [x2]
               	str	x3, [x2, #0x8]
               	mul	x7, x0, x1
               	mov	w2, w0
               	lsr	x4, x0, #32
               	mov	w5, w1
               	lsr	x6, x1, #32
               	mul	x8, x2, x5
               	lsr	x8, x8, #32
               	mul	x5, x4, x5
               	add	x5, x5, x8
               	mov	w8, w5
               	lsr	x5, x5, #32
               	mul	x2, x2, x6
               	add	x2, x2, x8
               	lsr	x2, x2, #32
               	mul	x4, x4, x6
               	add	x4, x4, x5
               	add	x2, x4, x2
               	mul	x0, x0, x3
               	mul	x1, x3, x1
               	add	x0, x2, x0
               	add	x1, x0, x1
               	sub	x0, x29, #0x108
               	str	x7, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x48
               	mov	x1, #0x23               // =35
               	mov	x2, #0x0                // =0
               	mov	x3, #0x5                // =5
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1a0]
               	ldp	x20, x21, [sp], #0x1b0
               	ret
               	sub	x7, x29, #0x48
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x118
               	str	x2, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	lsl	x2, x2, #36
               	sub	x0, x29, #0x128
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x0, #0xfffd             // =65533
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mul	x8, x1, x0
               	mov	w3, w1
               	lsr	x4, x1, #32
               	mov	x5, #0xfffd             // =65533
               	movk	x5, #0xffff, lsl #16
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	mul	x9, x3, x5
               	lsr	x9, x9, #32
               	mul	x5, x4, x5
               	add	x5, x5, x9
               	mov	w9, w5
               	lsr	x5, x5, #32
               	mul	x3, x3, x6
               	add	x3, x3, x9
               	lsr	x3, x3, #32
               	mul	x4, x4, x6
               	add	x4, x4, x5
               	add	x3, x4, x3
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x4, x1, x17
               	mul	x0, x2, x0
               	add	x2, x3, x4
               	add	x2, x2, x0
               	sub	x0, x29, #0x138
               	str	x8, [x0]
               	str	x2, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x7]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x7, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x7
               	sub	x0, x29, #0x48
               	mov	x2, #0xffd000000000     // =281268818280448
               	movk	x2, #0xffff, lsl #48
               	mov	x3, #0x6                // =6
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1a0]
               	ldp	x20, x21, [sp], #0x1b0
               	ret
               	mov	x2, #0x1                // =1
               	sub	x1, x29, #0x148
               	str	x2, [x1]
               	mov	x0, #0x0                // =0
               	str	x0, [x1, #0x8]
               	lsl	x2, x2, #32
               	sub	x1, x29, #0x158
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	add	x3, x0, #0x5
               	cmp	x3, x0
               	cset	x1, lo
               	add	x2, x2, #0x0
               	add	x2, x2, x1
               	sub	x1, x29, #0x168
               	str	x3, [x1]
               	str	x2, [x1, #0x8]
               	sub	x2, x29, #0x58
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x2, x29, #0x58
               	ldr	x1, [x2]
               	ldr	x5, [x2, #0x8]
               	lsl	x6, x1, #4
               	mov	w2, w1
               	lsr	x3, x1, #32
               	lsl	x4, x2, #4
               	lsr	x4, x4, #32
               	lsl	x7, x3, #4
               	add	x4, x7, x4
               	mov	w7, w4
               	lsr	x4, x4, #32
               	mul	x2, x2, x0
               	add	x2, x2, x7
               	lsr	x2, x2, #32
               	mul	x3, x3, x0
               	add	x3, x3, x4
               	add	x2, x3, x2
               	mul	x0, x1, x0
               	lsl	x1, x5, #4
               	add	x0, x2, x0
               	add	x1, x0, x1
               	sub	x0, x29, #0x178
               	str	x6, [x0]
               	str	x1, [x0, #0x8]
               	mov	x1, #0x50               // =80
               	mov	x2, #0x1000000000       // =68719476736
               	mov	x3, #0x7                // =7
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1a0]
               	ldp	x20, x21, [sp], #0x1b0
               	ret
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x58
               	ldr	x0, [x2]
               	ldr	x4, [x2, #0x8]
               	lsl	x5, x0, #4
               	mov	w2, w0
               	lsr	x3, x0, #32
               	lsl	x6, x2, #4
               	lsr	x6, x6, #32
               	mul	x2, x1, x2
               	add	x2, x2, x6
               	mov	w6, w2
               	lsr	x2, x2, #32
               	lsl	x7, x3, #4
               	add	x6, x7, x6
               	lsr	x6, x6, #32
               	mul	x3, x1, x3
               	add	x2, x3, x2
               	add	x2, x2, x6
               	lsl	x3, x4, #4
               	mul	x0, x1, x0
               	add	x1, x2, x3
               	add	x1, x1, x0
               	sub	x0, x29, #0x188
               	str	x5, [x0]
               	str	x1, [x0, #0x8]
               	mov	x1, #0x50               // =80
               	mov	x2, #0x1000000000       // =68719476736
               	mov	x3, #0x8                // =8
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1a0]
               	ldp	x20, x21, [sp], #0x1b0
               	ret
               	sub	x0, x29, #0x28
               	sub	x1, x29, #0x68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x68
               	ldr	x1, [x0]
               	ldr	x7, [x0, #0x8]
               	mov	x2, #0x7c15             // =31765
               	movk	x2, #0x7f4a, lsl #16
               	movk	x2, #0x79b9, lsl #32
               	movk	x2, #0x9e37, lsl #48
               	mul	x8, x1, x2
               	mov	w3, w1
               	lsr	x4, x1, #32
               	mov	x5, #0x7c15             // =31765
               	movk	x5, #0x7f4a, lsl #16
               	mov	x6, #0x79b9             // =31161
               	movk	x6, #0x9e37, lsl #16
               	mul	x9, x3, x5
               	lsr	x9, x9, #32
               	mul	x5, x4, x5
               	add	x5, x5, x9
               	mov	w9, w5
               	lsr	x5, x5, #32
               	mul	x3, x3, x6
               	add	x3, x3, x9
               	lsr	x3, x3, #32
               	mul	x4, x4, x6
               	add	x4, x4, x5
               	add	x3, x4, x3
               	mov	x17, #0x0               // =0
               	mul	x1, x1, x17
               	mul	x2, x7, x2
               	add	x1, x3, x1
               	add	x1, x1, x2
               	str	x8, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x68
               	mov	x1, #0x6250             // =25168
               	movk	x1, #0xfb12, lsl #16
               	movk	x1, #0xfba, lsl #32
               	movk	x1, #0xe1dd, lsl #48
               	mov	x2, #0x37a7             // =14247
               	movk	x2, #0x84a5, lsl #16
               	movk	x2, #0x4fc9, lsl #32
               	movk	x2, #0xab46, lsl #48
               	mov	x3, #0x9                // =9
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1a0]
               	ldp	x20, x21, [sp], #0x1b0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x1a0]
               	ldp	x20, x21, [sp], #0x1b0
               	ret
