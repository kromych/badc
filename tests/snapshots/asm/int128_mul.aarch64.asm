
int128_mul.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<mulhi>:
               	mov	x3, #0x0                // =0
               	mov	w2, w0
               	lsr	x4, x0, #32
               	mov	w5, w1
               	lsr	x6, x1, #32
               	mul	x7, x2, x5
               	lsr	x7, x7, #32
               	mul	x5, x4, x5
               	add	x5, x5, x7
               	mov	w7, w5
               	lsr	x5, x5, #32
               	mul	x2, x2, x6
               	add	x2, x2, x7
               	lsr	x2, x2, #32
               	mul	x4, x4, x6
               	add	x4, x4, x5
               	add	x2, x4, x2
               	mul	x0, x0, x3
               	mul	x1, x3, x1
               	add	x0, x2, x0
               	add	x1, x0, x1
               	mov	x0, x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	sub	sp, sp, #0x50
               	mov	x16, sp
               	and	sp, x16, #0xfffffffffffffff0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x21, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x22, [x0]
               	mov	x1, #0x0                // =0
               	mul	x20, x21, x22
               	mov	w0, w21
               	lsr	x2, x21, #32
               	mov	w3, w22
               	lsr	x4, x22, #32
               	mul	x5, x0, x3
               	lsr	x5, x5, #32
               	mul	x3, x2, x3
               	add	x3, x3, x5
               	mov	w5, w3
               	lsr	x3, x3, #32
               	mul	x0, x0, x4
               	add	x0, x0, x5
               	lsr	x0, x0, #32
               	mul	x2, x2, x4
               	add	x2, x2, x3
               	add	x0, x2, x0
               	mul	x2, x21, x1
               	mul	x1, x1, x22
               	add	x0, x0, x2
               	add	x23, x0, x1
               	mov	x17, #0x5d10            // =23824
               	movk	x17, #0x4bb, lsl #16
               	movk	x17, #0x45c, lsl #32
               	movk	x17, #0xe5cf, lsl #48
               	cmp	x20, x17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x17, #0x3a3b            // =14907
               	movk	x17, #0x9b83, lsl #16
               	movk	x17, #0x6474, lsl #32
               	movk	x17, #0xddbf, lsl #48
               	cmp	x23, x17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	sub	sp, x29, #0x20
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	mov	x17, #0x3a3b            // =14907
               	movk	x17, #0x9b83, lsl #16
               	movk	x17, #0x6474, lsl #32
               	movk	x17, #0xddbf, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0x20
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mul	x5, x21, x22
               	mul	x0, x21, x22
               	cmp	x5, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	sub	sp, x29, #0x20
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mul	x4, x20, x20
               	mov	w0, w20
               	lsr	x1, x20, #32
               	mov	w2, w20
               	lsr	x3, x20, #32
               	mul	x5, x0, x2
               	lsr	x5, x5, #32
               	mul	x2, x1, x2
               	add	x2, x2, x5
               	mov	w5, w2
               	lsr	x2, x2, #32
               	mul	x0, x0, x3
               	add	x0, x0, x5
               	lsr	x0, x0, #32
               	mul	x1, x1, x3
               	add	x1, x1, x2
               	add	x0, x1, x0
               	mul	x1, x20, x23
               	mul	x2, x23, x20
               	add	x0, x0, x1
               	add	x2, x0, x2
               	mov	x17, #0xa100            // =41216
               	movk	x17, #0x9734, lsl #16
               	movk	x17, #0xc789, lsl #32
               	movk	x17, #0x6189, lsl #48
               	cmp	x4, x17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x17, #0x218             // =536
               	movk	x17, #0x6042, lsl #16
               	movk	x17, #0x4ab6, lsl #32
               	movk	x17, #0x95fa, lsl #48
               	cmp	x2, x17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	sub	sp, x29, #0x20
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x7c15             // =31765
               	movk	x0, #0x7f4a, lsl #16
               	movk	x0, #0x79b9, lsl #32
               	movk	x0, #0x9e37, lsl #48
               	mul	x5, x20, x0
               	mov	w1, w20
               	lsr	x2, x20, #32
               	mov	x3, #0x7c15             // =31765
               	movk	x3, #0x7f4a, lsl #16
               	mov	x4, #0x79b9             // =31161
               	movk	x4, #0x9e37, lsl #16
               	mul	x6, x1, x3
               	lsr	x6, x6, #32
               	mul	x3, x2, x3
               	add	x3, x3, x6
               	mov	w6, w3
               	lsr	x3, x3, #32
               	mul	x1, x1, x4
               	add	x1, x1, x6
               	lsr	x1, x1, #32
               	mul	x2, x2, x4
               	add	x2, x2, x3
               	add	x1, x2, x1
               	mov	x17, #0x0               // =0
               	mul	x2, x20, x17
               	mul	x0, x23, x0
               	add	x1, x1, x2
               	add	x2, x1, x0
               	mov	x17, #0x6250            // =25168
               	movk	x17, #0xfb12, lsl #16
               	movk	x17, #0xfba, lsl #32
               	movk	x17, #0xe1dd, lsl #48
               	cmp	x5, x17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x17, #0x37a7            // =14247
               	movk	x17, #0x84a5, lsl #16
               	movk	x17, #0x4fc9, lsl #32
               	movk	x17, #0xab46, lsl #48
               	cmp	x2, x17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	sub	sp, x29, #0x20
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x20
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
