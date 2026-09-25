
bitnot_promoted_compare.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x0                // =0
               	sturb	w0, [x29, #-0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w2, [x1]
               	sturb	w0, [x29, #-0x8]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w2, w17
               	b.hs	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w2, [x1]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w2, w17
               	b.lo	<addr>
               	ldr	w2, [x1]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w2, w17
               	b.lo	<addr>
               	ldr	w2, [x1]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w2, w17
               	b.hs	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w3, [x2]
               	ldr	w3, [x1]
               	ldr	w3, [x1]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w3, w17
               	b.hs	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w4, [x1]
               	mov	x3, #0xffffffff         // =4294967295
               	udiv	x4, x3, x4
               	eor	x4, x4, #0x1
               	cbnz	w4, <addr>
               	ldr	w4, [x2]
               	udiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	eor	x3, x3, #0x3
               	cbz	w3, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w3, [x1]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w3, w17
               	b.ne	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	strb	w0, [x3]
               	ldr	w3, [x1]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w3, w17
               	b.hs	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w3, [x29, #-0x8]
               	mvn	x3, x3
               	lsl	x3, x3, #1
               	mov	x17, #0xfffffffe        // =4294967294
               	cmp	w3, w17
               	b.ne	<addr>
               	ldurb	w3, [x29, #-0x8]
               	mvn	x3, x3
               	mov	w3, w3
               	lsr	x3, x3, #1
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w3, [x29, #-0x8]
               	mvn	x3, x3
               	ldr	w4, [x1]
               	cmp	w3, w4
               	b.hi	<addr>
               	ldurb	w3, [x29, #-0x8]
               	mvn	x3, x3
               	asr	x3, x3, #1
               	mov	x17, #-0x1              // =-1
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0xf                // =15
               	sturb	w3, [x29, #-0x8]
               	ldr	w2, [x2]
               	mov	x17, #0xfffffff0        // =4294967280
               	cmp	w2, w17
               	b.hs	<addr>
               	ldr	w1, [x1]
               	mov	x17, #0xfffffff0        // =4294967280
               	cmp	w1, w17
               	b.lo	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
