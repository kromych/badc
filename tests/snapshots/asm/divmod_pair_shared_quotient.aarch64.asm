
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
               	mov	x5, x0
               	mov	x7, x3
               	mov	x4, x2
               	mov	x6, x1
               	mov	w0, w5
               	mov	w1, w6
               	udiv	x2, x0, x1
               	cmp	w2, w4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mul	x3, x2, x1
               	sub	x8, x0, x3
               	mov	w9, w7
               	cmp	x8, x9
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	add	x9, x2, x8
               	add	x10, x4, x7
               	cmp	w9, w10
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	w9, w10
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	add	x1, x3, x8
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
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
               	cbz	w0, <addr>
               	add	x0, x0, #0x1e
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xffffffff         // =4294967295
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
               	cbnz	w0, <addr>
               	mov	x1, #0xffffffff         // =4294967295
               	mov	x3, #0xfffffffe         // =4294967294
               	mov	x2, #0x1                // =1
               	mov	x0, x1
               	mov	x1, x3
               	mov	x3, x2
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x3                // =3
               	mov	x0, x1
               	mov	x3, x1
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x16
               	bl	<addr>
               	cbnz	w0, <addr>
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
               	mov	x4, #0xa                // =10
               	mov	x6, #0x999a             // =39322
               	movk	x6, #0x1999, lsl #16
               	mov	x1, #0x0                // =0
               	mul	x5, x0, x6
               	lsr	x3, x5, #32
               	msub	x2, x3, x4, x0
               	cmp	w2, #0x64
               	b.gt	<addr>
               	add	x1, x1, x2
               	mov	x0, x3
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
               	mov	x1, #-0x1               // =-1
               	b	<addr>
