
bitnot_promoted_compare.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	adrp	x1, <page>
               	ldr	w0, [x1, #0xc]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.hs	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	w0, [x1, #0xc]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.lo	<addr>
               	ldr	w0, [x1, #0xc]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.lo	<addr>
               	ldr	w0, [x1, #0xc]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.hs	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x2, <page>
               	ldr	w0, [x2, #0x10]
               	ldr	w0, [x1, #0xc]
               	ldr	w0, [x1, #0xc]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.hs	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	w3, [x1, #0xc]
               	mov	x0, #0xffffffff         // =4294967295
               	udiv	w3, w0, w3
               	cmp	w3, #0x1
               	b.ne	<addr>
               	ldr	w3, [x2, #0x10]
               	udiv	w17, w0, w3
               	msub	w0, w17, w3, w0
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldr	w0, [x1, #0xc]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x3, <page>
               	mov	x0, #0x0                // =0
               	strb	w0, [x3, #0x30]
               	ldr	w3, [x1, #0xc]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w3, w17
               	b.hs	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldr	w3, [x1, #0xc]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w3, w17
               	b.lo	<addr>
               	ldr	w2, [x2, #0x10]
               	mov	x17, #0xfffffff0        // =4294967280
               	cmp	w2, w17
               	b.hs	<addr>
               	ldr	w1, [x1, #0xc]
               	mov	x17, #0xfffffff0        // =4294967280
               	cmp	w1, w17
               	b.lo	<addr>
               	ret
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x7                // =7
               	ret
