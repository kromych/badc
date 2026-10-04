
dead_phi_web.aarch64:	file format elf64-littleaarch64

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

<quot128>:
               	cbz	x0, <addr>
               	cmp	x0, x2
               	b.lo	<addr>
               	udiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	clz	x5, x2
               	lsl	x8, x2, x5
               	lsr	x3, x8, #32
               	mov	w4, w8
               	eor	x2, x5, #0x3f
               	lsr	x6, x1, #1
               	lsr	x2, x6, x2
               	lsl	x0, x0, x5
               	orr	x9, x0, x2
               	lsl	x0, x1, x5
               	lsr	x2, x0, #32
               	mov	w5, w0
               	udiv	x0, x9, x3
               	msub	x1, x0, x3, x9
               	lsr	x6, x0, #32
               	cbnz	x6, <addr>
               	mul	x6, x0, x4
               	lsl	x7, x1, #32
               	orr	x7, x7, x2
               	cmp	x6, x7
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x6, x1, #32
               	cbz	x6, <addr>
               	lsl	x1, x9, #32
               	orr	x1, x1, x2
               	msub	x2, x0, x8, x1
               	udiv	x1, x2, x3
               	msub	x2, x1, x3, x2
               	lsr	x6, x1, #32
               	cbnz	x6, <addr>
               	mul	x6, x1, x4
               	lsl	x7, x2, #32
               	orr	x7, x7, x5
               	cmp	x6, x7
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x6, x2, #32
               	cbz	x6, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	ret
               	udiv	x0, x1, x2
               	b	<addr>

<rem128>:
               	cbz	x0, <addr>
               	cmp	x0, x2
               	b.lo	<addr>
               	udiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	clz	x3, x2
               	lsl	x10, x2, x3
               	lsr	x5, x10, #32
               	mov	w6, w10
               	eor	x4, x3, #0x3f
               	lsr	x7, x1, #1
               	lsr	x4, x7, x4
               	lsl	x0, x0, x3
               	orr	x11, x0, x4
               	lsl	x0, x1, x3
               	lsr	x4, x0, #32
               	mov	w7, w0
               	udiv	x0, x11, x5
               	msub	x3, x0, x5, x11
               	lsr	x8, x0, #32
               	cbnz	x8, <addr>
               	mul	x8, x0, x6
               	lsl	x9, x3, #32
               	orr	x9, x9, x4
               	cmp	x8, x9
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x3, x3, x5
               	lsr	x8, x3, #32
               	cbz	x8, <addr>
               	lsl	x3, x11, #32
               	orr	x3, x3, x4
               	msub	x4, x0, x10, x3
               	udiv	x3, x4, x5
               	msub	x4, x3, x5, x4
               	lsr	x8, x3, #32
               	cbnz	x8, <addr>
               	mul	x8, x3, x6
               	lsl	x9, x4, #32
               	orr	x9, x9, x7
               	cmp	x8, x9
               	b.ls	<addr>
               	sub	x3, x3, #0x1
               	add	x4, x4, x5
               	lsr	x8, x4, #32
               	cbz	x8, <addr>
               	lsl	x0, x0, #32
               	orr	x3, x0, x3
               	msub	x0, x3, x2, x1
               	ret
               	udiv	x17, x1, x2
               	msub	x0, x17, x2, x1
               	b	<addr>

<rotate_dead>:
               	mov	x1, #0x0                // =0
               	cmp	w1, w0
               	b.ge	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w0
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret

<ref_quot>:
               	cbz	x0, <addr>
               	cmp	x0, x2
               	b.lo	<addr>
               	udiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	clz	x5, x2
               	lsl	x8, x2, x5
               	lsr	x3, x8, #32
               	mov	w4, w8
               	eor	x2, x5, #0x3f
               	lsr	x6, x1, #1
               	lsr	x2, x6, x2
               	lsl	x0, x0, x5
               	orr	x9, x0, x2
               	lsl	x0, x1, x5
               	lsr	x2, x0, #32
               	mov	w5, w0
               	udiv	x0, x9, x3
               	msub	x1, x0, x3, x9
               	lsr	x6, x0, #32
               	cbnz	x6, <addr>
               	mul	x6, x0, x4
               	lsl	x7, x1, #32
               	orr	x7, x7, x2
               	cmp	x6, x7
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x6, x1, #32
               	cbz	x6, <addr>
               	lsl	x1, x9, #32
               	orr	x1, x1, x2
               	msub	x2, x0, x8, x1
               	udiv	x1, x2, x3
               	msub	x2, x1, x3, x2
               	lsr	x6, x1, #32
               	cbnz	x6, <addr>
               	mul	x6, x1, x4
               	lsl	x7, x2, #32
               	orr	x7, x7, x5
               	cmp	x6, x7
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x6, x2, #32
               	cbz	x6, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	ret
               	udiv	x0, x1, x2
               	b	<addr>

<ref_rem>:
               	cbz	x0, <addr>
               	cmp	x0, x2
               	b.lo	<addr>
               	udiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	clz	x3, x2
               	lsl	x10, x2, x3
               	lsr	x5, x10, #32
               	mov	w6, w10
               	eor	x4, x3, #0x3f
               	lsr	x7, x1, #1
               	lsr	x4, x7, x4
               	lsl	x0, x0, x3
               	orr	x11, x0, x4
               	lsl	x0, x1, x3
               	lsr	x4, x0, #32
               	mov	w7, w0
               	udiv	x0, x11, x5
               	msub	x3, x0, x5, x11
               	lsr	x8, x0, #32
               	cbnz	x8, <addr>
               	mul	x8, x0, x6
               	lsl	x9, x3, #32
               	orr	x9, x9, x4
               	cmp	x8, x9
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x3, x3, x5
               	lsr	x8, x3, #32
               	cbz	x8, <addr>
               	lsl	x3, x11, #32
               	orr	x3, x3, x4
               	msub	x4, x0, x10, x3
               	udiv	x3, x4, x5
               	msub	x4, x3, x5, x4
               	lsr	x8, x3, #32
               	cbnz	x8, <addr>
               	mul	x8, x3, x6
               	lsl	x9, x4, #32
               	orr	x9, x9, x7
               	cmp	x8, x9
               	b.ls	<addr>
               	sub	x3, x3, #0x1
               	add	x4, x4, x5
               	lsr	x8, x4, #32
               	cbz	x8, <addr>
               	lsl	x0, x0, #32
               	orr	x3, x0, x3
               	msub	x0, x3, x2, x1
               	ret
               	udiv	x17, x1, x2
               	msub	x0, x17, x2, x1
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x21, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x22, [x0]
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	mov	x23, x0
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	cmp	x23, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	mov	x23, x0
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	cmp	x23, x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	mov	x2, #0x3                // =3
               	mov	x1, x21
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, #0x0                // =0
               	mov	x2, #0x3                // =3
               	mov	x1, x21
               	bl	<addr>
               	cmp	x22, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	mov	x0, x20
               	bl	<addr>
               	cmp	x22, x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, x20
               	mov	x2, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, x20
               	mov	x2, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x22, x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, x20
               	mov	x2, x21
               	mov	x1, x21
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, x20
               	mov	x2, x21
               	mov	x1, x21
               	bl	<addr>
               	cmp	x22, x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	bl	<addr>
               	cmp	w0, #0x0
               	cset	x0, ne
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
