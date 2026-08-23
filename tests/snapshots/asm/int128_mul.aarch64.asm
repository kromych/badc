
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
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x3, #0x0                // =0
               	mul	x2, x0, x1
               	mov	w4, w0
               	lsr	x5, x0, #32
               	mov	w6, w1
               	lsr	x7, x1, #32
               	mul	x11, x4, x6
               	lsr	x12, x11, #32
               	mul	x13, x5, x6
               	add	x8, x13, x12
               	mov	w14, w8
               	lsr	x15, x8, #32
               	mul	x20, x4, x7
               	add	x21, x20, x14
               	lsr	x22, x21, #32
               	mul	x23, x5, x7
               	add	x24, x23, x15
               	add	x9, x24, x22
               	mul	x25, x0, x3
               	mul	x10, x3, x1
               	add	x9, x9, x25
               	add	x9, x9, x10
               	mov	x17, #0x5d10            // =23824
               	movk	x17, #0x4bb, lsl #16
               	movk	x17, #0x45c, lsl #32
               	movk	x17, #0xe5cf, lsl #48
               	cmp	x2, x17
               	cset	x10, ne
               	cbnz	x10, <addr>
               	mov	x17, #0x3a3b            // =14907
               	movk	x17, #0x9b83, lsl #16
               	movk	x17, #0x6474, lsl #32
               	movk	x17, #0xddbf, lsl #48
               	cmp	x9, x17
               	cset	x10, ne
               	cbz	x10, <addr>
               	mov	x10, #0x1               // =1
               	cbz	x10, <addr>
               	sxtw	x0, w10
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	add	x4, x24, x22
               	mul	x3, x3, x1
               	add	x4, x4, x25
               	add	x3, x4, x3
               	mov	x17, #0x3a3b            // =14907
               	movk	x17, #0x9b83, lsl #16
               	movk	x17, #0x6474, lsl #32
               	movk	x17, #0xddbf, lsl #48
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mul	x4, x0, x1
               	cmp	x4, x4
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mul	x5, x2, x2
               	mov	w0, w2
               	lsr	x1, x2, #32
               	mul	x3, x0, x0
               	lsr	x4, x3, #32
               	mul	x3, x1, x0
               	add	x4, x3, x4
               	mov	w6, w4
               	lsr	x4, x4, #32
               	add	x0, x3, x6
               	lsr	x0, x0, #32
               	mul	x1, x1, x1
               	add	x1, x1, x4
               	add	x1, x1, x0
               	mul	x0, x2, x9
               	add	x1, x1, x0
               	add	x1, x1, x0
               	mov	x17, #0xa100            // =41216
               	movk	x17, #0x9734, lsl #16
               	movk	x17, #0xc789, lsl #32
               	movk	x17, #0x6189, lsl #48
               	cmp	x5, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x17, #0x218             // =536
               	movk	x17, #0x6042, lsl #16
               	movk	x17, #0x4ab6, lsl #32
               	movk	x17, #0x95fa, lsl #48
               	cmp	x1, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x3, x0
               	mov	x1, x0
               	mov	x3, x0
               	mov	x1, x0
               	mov	x3, x0
               	mov	x1, x0
               	mov	x0, #0x7c15             // =31765
               	movk	x0, #0x7f4a, lsl #16
               	movk	x0, #0x79b9, lsl #32
               	movk	x0, #0x9e37, lsl #48
               	mul	x6, x2, x0
               	mov	w1, w2
               	lsr	x3, x2, #32
               	mov	x4, #0x7c15             // =31765
               	movk	x4, #0x7f4a, lsl #16
               	mov	x5, #0x79b9             // =31161
               	movk	x5, #0x9e37, lsl #16
               	mul	x7, x1, x4
               	lsr	x7, x7, #32
               	mul	x4, x3, x4
               	add	x4, x4, x7
               	mov	w7, w4
               	lsr	x4, x4, #32
               	mul	x1, x1, x5
               	add	x1, x1, x7
               	lsr	x1, x1, #32
               	mul	x3, x3, x5
               	add	x3, x3, x4
               	add	x1, x3, x1
               	mov	x17, #0x0               // =0
               	mul	x2, x2, x17
               	mul	x0, x9, x0
               	add	x1, x1, x2
               	add	x1, x1, x0
               	mov	x17, #0x6250            // =25168
               	movk	x17, #0xfb12, lsl #16
               	movk	x17, #0xfba, lsl #32
               	movk	x17, #0xe1dd, lsl #48
               	cmp	x6, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x17, #0x37a7            // =14247
               	movk	x17, #0x84a5, lsl #16
               	movk	x17, #0x4fc9, lsl #32
               	movk	x17, #0xab46, lsl #48
               	cmp	x1, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x10, x3
               	b	<addr>
               	b	<addr>
