
int128_mul.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x5, #0x0                // =0
               	mul	x2, x1, x0
               	mov	w6, w1
               	lsr	x3, x1, #32
               	mov	w7, w0
               	lsr	x4, x0, #32
               	mul	x11, x6, x7
               	lsr	x12, x11, #32
               	madd	x9, x3, x7, x12
               	mov	w13, w9
               	lsr	x14, x9, #32
               	madd	x15, x6, x4, x13
               	lsr	x20, x15, #32
               	madd	x21, x3, x4, x14
               	add	x8, x21, x20
               	mul	x22, x1, x5
               	add	x8, x8, x22
               	madd	x8, x5, x0, x8
               	mov	x17, #0x5d10            // =23824
               	movk	x17, #0x4bb, lsl #16
               	movk	x17, #0x45c, lsl #32
               	movk	x17, #0xe5cf, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	mov	x17, #0x3a3b            // =14907
               	movk	x17, #0x9b83, lsl #16
               	movk	x17, #0x6474, lsl #32
               	movk	x17, #0xddbf, lsl #48
               	cmp	x8, x17
               	cset	x10, ne
               	cbz	x10, <addr>
               	mov	x10, #0x1               // =1
               	cbz	x10, <addr>
               	sxtw	x0, w10
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	add	x3, x21, x20
               	add	x3, x3, x22
               	madd	x3, x5, x0, x3
               	mov	x17, #0x3a3b            // =14907
               	movk	x17, #0x9b83, lsl #16
               	movk	x17, #0x6474, lsl #32
               	movk	x17, #0xddbf, lsl #48
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mul	x4, x1, x0
               	cmp	x4, x4
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mul	x5, x2, x2
               	mov	w1, w2
               	lsr	x0, x2, #32
               	mul	x3, x1, x1
               	lsr	x4, x3, #32
               	mul	x3, x0, x1
               	add	x4, x3, x4
               	mov	w6, w4
               	lsr	x4, x4, #32
               	add	x1, x3, x6
               	lsr	x1, x1, #32
               	madd	x0, x0, x0, x4
               	add	x1, x0, x1
               	mul	x0, x2, x8
               	add	x1, x1, x0
               	add	x0, x1, x0
               	mov	x17, #0xa100            // =41216
               	movk	x17, #0x9734, lsl #16
               	movk	x17, #0xc789, lsl #32
               	movk	x17, #0x6189, lsl #48
               	cmp	x5, x17
               	b.ne	<addr>
               	mov	x17, #0x218             // =536
               	movk	x17, #0x6042, lsl #16
               	movk	x17, #0x4ab6, lsl #32
               	movk	x17, #0x95fa, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x3, x0
               	mov	x1, x0
               	mov	x3, x0
               	mov	x1, x0
               	mov	x3, x0
               	mov	x1, x0
               	mov	x3, #0x7c15             // =31765
               	movk	x3, #0x7f4a, lsl #16
               	movk	x3, #0x79b9, lsl #32
               	movk	x3, #0x9e37, lsl #48
               	mul	x6, x2, x3
               	mov	w4, w2
               	lsr	x0, x2, #32
               	mov	x5, #0x7c15             // =31765
               	movk	x5, #0x7f4a, lsl #16
               	mov	x1, #0x79b9             // =31161
               	movk	x1, #0x9e37, lsl #16
               	mul	x7, x4, x5
               	lsr	x7, x7, #32
               	madd	x5, x0, x5, x7
               	mov	w7, w5
               	lsr	x5, x5, #32
               	madd	x4, x4, x1, x7
               	lsr	x4, x4, #32
               	madd	x0, x0, x1, x5
               	add	x0, x0, x4
               	mov	x17, #0x0               // =0
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	madd	x0, x8, x3, x0
               	mov	x17, #0x6250            // =25168
               	movk	x17, #0xfb12, lsl #16
               	movk	x17, #0xfba, lsl #32
               	movk	x17, #0xe1dd, lsl #48
               	cmp	x6, x17
               	b.ne	<addr>
               	mov	x17, #0x37a7            // =14247
               	movk	x17, #0x84a5, lsl #16
               	movk	x17, #0x4fc9, lsl #32
               	movk	x17, #0xab46, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x10, x5
               	b	<addr>
