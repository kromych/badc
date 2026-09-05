
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x0, x1
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x0, x1
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x0, x1
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x0, x1
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x0, x1
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x0, x1
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x1, #0x11               // =17
               	mov	x2, #0x5                // =5
               	mov	x3, #0x3                // =3
               	mov	x0, #0x2                // =2
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x1, w0
               	cbz	x1, <addr>
               	add	x0, x0, #0x1e
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	mov	x2, #0x7                // =7
               	mov	x3, #0x4924             // =18724
               	movk	x3, #0x2492, lsl #16
               	mov	x0, #0x3                // =3
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x1, w0
               	cbz	x1, <addr>
               	b	<addr>
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	mov	x3, #0xfffe             // =65534
               	movk	x3, #0xffff, lsl #16
               	mov	x2, #0x1                // =1
               	mov	x0, x1
               	mov	x1, x3
               	mov	x3, x2
               	bl	<addr>
               	sxtw	x1, w0
               	cbz	x1, <addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x3                // =3
               	mov	x0, x1
               	mov	x3, x1
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x16
               	bl	<addr>
               	sxtw	x1, w0
               	cbz	x1, <addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x0, x1
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
               	ldp	x29, x30, [sp], #0x10
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
               	ldp	x29, x30, [sp], #0x10
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
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
