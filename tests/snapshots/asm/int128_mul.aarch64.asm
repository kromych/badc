
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x3, #0x0                // =0
               	mul	x0, x2, x1
               	mov	w4, w2
               	lsr	x5, x2, #32
               	mov	w6, w1
               	lsr	x7, x1, #32
               	mul	x8, x4, x6
               	lsr	x8, x8, #32
               	madd	x6, x5, x6, x8
               	mov	w8, w6
               	lsr	x9, x6, #32
               	madd	x4, x4, x7, x8
               	lsr	x6, x4, #32
               	madd	x7, x5, x7, x9
               	add	x4, x7, x6
               	mul	x8, x2, x3
               	add	x4, x4, x8
               	madd	x4, x3, x1, x4
               	mov	x17, #0x5d10            // =23824
               	movk	x17, #0x4bb, lsl #16
               	movk	x17, #0x45c, lsl #32
               	movk	x17, #0xe5cf, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x17, #0x3a3b            // =14907
               	movk	x17, #0x9b83, lsl #16
               	movk	x17, #0x6474, lsl #32
               	movk	x17, #0xddbf, lsl #48
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x5, #0x1                // =1
               	cbz	x5, <addr>
               	mov	x0, x5
               	ret
               	add	x5, x7, x6
               	add	x5, x5, x8
               	madd	x3, x3, x1, x5
               	mov	x17, #0x3a3b            // =14907
               	movk	x17, #0x9b83, lsl #16
               	movk	x17, #0x6474, lsl #32
               	movk	x17, #0xddbf, lsl #48
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mul	x1, x2, x1
               	cmp	x1, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mul	x5, x0, x0
               	mov	w1, w0
               	lsr	x2, x0, #32
               	mul	x3, x1, x1
               	lsr	x3, x3, #32
               	mul	x1, x2, x1
               	add	x3, x1, x3
               	mov	w6, w3
               	lsr	x3, x3, #32
               	add	x1, x1, x6
               	lsr	x1, x1, #32
               	madd	x2, x2, x2, x3
               	add	x2, x2, x1
               	mul	x1, x0, x4
               	add	x2, x2, x1
               	add	x1, x2, x1
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
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x1, #0x4                // =4
               	cbz	x1, <addr>
               	mov	x0, x1
               	ret
               	mov	x1, #0x7c15             // =31765
               	movk	x1, #0x7f4a, lsl #16
               	movk	x1, #0x79b9, lsl #32
               	movk	x1, #0x9e37, lsl #48
               	mul	x7, x0, x1
               	mov	w2, w0
               	lsr	x3, x0, #32
               	mov	x5, #0x7c15             // =31765
               	movk	x5, #0x7f4a, lsl #16
               	mov	x6, #0x79b9             // =31161
               	movk	x6, #0x9e37, lsl #16
               	mul	x8, x2, x5
               	lsr	x8, x8, #32
               	madd	x5, x3, x5, x8
               	mov	w8, w5
               	lsr	x5, x5, #32
               	madd	x2, x2, x6, x8
               	lsr	x2, x2, #32
               	madd	x3, x3, x6, x5
               	add	x2, x3, x2
               	mov	x17, #0x0               // =0
               	mul	x0, x0, x17
               	add	x0, x2, x0
               	madd	x0, x4, x1, x0
               	mov	x17, #0x6250            // =25168
               	movk	x17, #0xfb12, lsl #16
               	movk	x17, #0xfba, lsl #32
               	movk	x17, #0xe1dd, lsl #48
               	cmp	x7, x17
               	b.ne	<addr>
               	mov	x17, #0x37a7            // =14247
               	movk	x17, #0x84a5, lsl #16
               	movk	x17, #0x4fc9, lsl #32
               	movk	x17, #0xab46, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	cbz	x0, <addr>
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x5, x3
               	b	<addr>
