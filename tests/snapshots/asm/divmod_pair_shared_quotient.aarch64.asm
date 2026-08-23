
divmod_pair_shared_quotient.aarch64:	file format elf64-littleaarch64

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

<check_uint>:
               	mov	x4, x0
               	mov	x6, x2
               	mov	x5, x1
               	mov	w1, w4
               	mov	w0, w5
               	udiv	x2, x1, x0
               	mov	w7, w6
               	cmp	x2, x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	msub	x8, x2, x0, x1
               	mov	w9, w3
               	cmp	x8, x9
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	add	x10, x2, x8
               	mov	w11, w10
               	add	x12, x7, x9
               	mov	w13, w12
               	cmp	w11, w13
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	w11, w13
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mul	x0, x2, x0
               	mov	w2, w0
               	sub	x0, x1, x0
               	add	x0, x2, x0
               	mov	w0, w0
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x11, #0x0               // =0
               	mov	x4, x11
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	lsl	x1, x10, #4
               	add	x2, x0, x1
               	ldrsw	x0, [x2]
               	ldrsw	x1, [x2, #0x4]
               	ldrsw	x5, [x2, #0x8]
               	ldrsw	x6, [x2, #0xc]
               	sdiv	x2, x0, x1
               	cmp	x2, x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x1, w0
               	cbz	x1, <addr>
               	b	<addr>
               	mul	x3, x2, x1
               	sub	x7, x0, x3
               	cmp	x7, x6
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	add	x8, x2, x7
               	add	x9, x5, x6
               	cmp	w8, w9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w8, w9
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	add	x1, x3, x7
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	mov	x0, x11
               	b	<addr>
               	add	x4, x10, #0x1
               	mov	w10, w4
               	cmp	w10, #0xc
               	b.lo	<addr>
               	mov	x9, #0x0                // =0
               	mov	x4, x9
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	lsl	x1, x6, #5
               	add	x2, x0, x1
               	ldr	x0, [x2]
               	ldr	x1, [x2, #0x8]
               	ldr	x7, [x2, #0x10]
               	ldr	x8, [x2, #0x18]
               	sdiv	x2, x0, x1
               	cmp	x2, x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x1, w0
               	cbz	x1, <addr>
               	b	<addr>
               	mul	x3, x2, x1
               	sub	x5, x0, x3
               	cmp	x5, x8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	add	x10, x2, x5
               	add	x11, x7, x8
               	cmp	x10, x11
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x10, x11
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	add	x1, x3, x5
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	mov	x0, x9
               	b	<addr>
               	add	x4, x6, #0x1
               	mov	w6, w4
               	cmp	w6, #0x8
               	b.lo	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	lsl	x1, x21, #4
               	add	x0, x0, x1
               	ldr	w1, [x0]
               	ldr	w2, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w0, [x0, #0xc]
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x1, w0
               	cbnz	x1, <addr>
               	add	x20, x21, #0x1
               	mov	w21, w20
               	cmp	w21, #0x4
               	b.lo	<addr>
               	mov	x9, #0x0                // =0
               	mov	x4, x9
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	lsl	x1, x6, #5
               	add	x2, x0, x1
               	ldr	x0, [x2]
               	ldr	x1, [x2, #0x8]
               	ldr	x7, [x2, #0x10]
               	ldr	x8, [x2, #0x18]
               	udiv	x2, x0, x1
               	cmp	x2, x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x1, w0
               	cbz	x1, <addr>
               	b	<addr>
               	mul	x3, x2, x1
               	sub	x5, x0, x3
               	cmp	x5, x8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	add	x10, x2, x5
               	add	x11, x7, x8
               	cmp	x10, x11
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x10, x11
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	add	x1, x3, x5
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	mov	x0, x9
               	b	<addr>
               	add	x4, x6, #0x1
               	mov	w6, w4
               	cmp	w6, #0x3
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x34               // =52
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x24a0             // =9376
               	mov	x2, #0xa                // =10
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x4, w0
               	sdiv	x5, x4, x2
               	msub	x3, x5, x2, x4
               	cmp	w3, #0x64
               	b.gt	<addr>
               	add	x1, x1, x3
               	mov	x0, x5
               	cmp	w0, #0x0
               	b.gt	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x19
               	b.eq	<addr>
               	mov	x0, #0x35               // =53
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x2, #0xa                // =10
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x4, w0
               	sdiv	x5, x4, x2
               	msub	x3, x5, x2, x4
               	cmp	w3, #0x64
               	b.gt	<addr>
               	add	x1, x1, x3
               	mov	x0, x5
               	cmp	w0, #0x0
               	b.gt	<addr>
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	mov	x0, #0x36               // =54
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	add	x0, x0, #0x28
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	add	x0, x0, #0x1e
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	add	x0, x0, #0x14
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	add	x0, x0, #0xa
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
