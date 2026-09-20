
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
               	mov	w0, w0
               	mov	w4, w1
               	udiv	x1, x0, x4
               	cmp	w1, w2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mul	x5, x1, x4
               	sub	x4, x0, x5
               	mov	w6, w3
               	cmp	x4, x6
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	add	x1, x1, x4
               	add	x2, x2, x3
               	cmp	w1, w2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	w1, w2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	add	x1, x5, x4
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x4, #0x0                // =0
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	mov	x1, x4
               	lsl	x0, x1, #4
               	add	x0, x8, x0
               	ldrsw	x2, [x0]
               	ldrsw	x3, [x0, #0x4]
               	ldrsw	x5, [x0, #0x8]
               	ldrsw	x6, [x0, #0xc]
               	sdiv	x0, x2, x3
               	cmp	x0, x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	b	<addr>
               	mul	x7, x0, x3
               	sub	x3, x2, x7
               	cmp	x3, x6
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	add	x0, x0, x3
               	add	x5, x5, x6
               	cmp	w0, w5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w0, w5
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	add	x0, x7, x3
               	cmp	w0, w2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	mov	x0, x4
               	add	x1, x1, #0x1
               	cmp	w1, #0xc
               	b.lo	<addr>
               	mov	x0, #0x11               // =17
               	mov	x1, #0x5                // =5
               	mov	x2, #0x3                // =3
               	mov	x3, #0x2                // =2
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	add	x0, x0, #0x1e
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffffffff         // =4294967295
               	mov	x1, #0x7                // =7
               	mov	x2, #0x4924             // =18724
               	movk	x2, #0x2492, lsl #16
               	mov	x3, #0x3                // =3
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0xffffffff         // =4294967295
               	mov	x1, #0xfffffffe         // =4294967294
               	mov	x2, #0x1                // =1
               	mov	x3, x2
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x3                // =3
               	mov	x2, x0
               	mov	x3, x0
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, x1
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x34               // =52
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x24a0             // =9376
               	mov	x3, #0xa                // =10
               	mov	x4, #0x999a             // =39322
               	movk	x4, #0x1999, lsl #16
               	mov	x1, #0x0                // =0
               	mul	x2, x0, x4
               	lsr	x2, x2, #32
               	msub	x0, x2, x3, x0
               	cmp	w0, #0x64
               	b.gt	<addr>
               	add	x1, x1, x0
               	mov	x0, x2
               	cmp	w0, #0x0
               	b.gt	<addr>
               	cmp	w1, #0x19
               	b.eq	<addr>
               	mov	x0, #0x35               // =53
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0xa
               	ldp	x29, x30, [sp], #0x10
               	ret
