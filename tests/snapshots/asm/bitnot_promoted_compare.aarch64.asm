
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
               	ldr	w2, [x1, #0xc]
               	sturb	w0, [x29, #-0x8]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w2, w17
               	b.hs	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w2, [x1, #0xc]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w2, w17
               	b.lo	<addr>
               	ldr	w2, [x1, #0xc]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w2, w17
               	b.lo	<addr>
               	ldr	w2, [x1, #0xc]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w2, w17
               	b.hs	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x3, <page>
               	ldr	w2, [x3, #0x10]
               	ldr	w2, [x1, #0xc]
               	ldr	w2, [x1, #0xc]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w2, w17
               	b.hs	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w4, [x1, #0xc]
               	mov	x2, #0xffffffff         // =4294967295
               	udiv	w4, w2, w4
               	cmp	w4, #0x1
               	b.ne	<addr>
               	ldr	w4, [x3, #0x10]
               	udiv	w17, w2, w4
               	msub	w2, w17, w4, w2
               	cmp	w2, #0x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w2, [x1, #0xc]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w2, w17
               	b.ne	<addr>
               	adrp	x2, <page>
               	strb	w0, [x2, #0x30]
               	ldr	w2, [x1, #0xc]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w2, w17
               	b.hs	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w2, [x29, #-0x8]
               	mvn	x4, x2
               	lsl	x4, x4, #1
               	mov	x17, #0xfffffffe        // =4294967294
               	cmp	w4, w17
               	b.ne	<addr>
               	mvn	x4, x2
               	mov	w4, w4
               	lsr	x4, x4, #1
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	w4, w17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mvn	x4, x2
               	ldr	w5, [x1, #0xc]
               	cmp	w4, w5
               	b.hi	<addr>
               	mvn	x2, x2
               	asr	x2, x2, #1
               	cmn	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xf                // =15
               	sturb	w2, [x29, #-0x8]
               	ldr	w2, [x3, #0x10]
               	mov	x17, #0xfffffff0        // =4294967280
               	cmp	w2, w17
               	b.hs	<addr>
               	ldr	w1, [x1, #0xc]
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
