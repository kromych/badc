
two_d_array_param_indexing.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x400
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x400
               	add	x1, x1, x0, lsl #2
               	str	wzr, [x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x100
               	b.lt	<addr>
               	mov	x0, #0x1234             // =4660
               	movk	x0, #0x10, lsl #16
               	str	w0, [sp, #0x14]
               	ldrh	w0, [sp, #0x14]
               	ldrh	w1, [sp, #0x16]
               	add	x0, x0, x1
               	mov	x17, #0x1244            // =4676
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x3, #0xc                // =12
               	mov	x4, #0x64               // =100
               	sub	x1, x29, #0x78
               	mul	x2, x0, x3
               	add	x1, x1, x2
               	mul	x2, x0, x4
               	str	w2, [x1]
               	add	x5, x2, #0x1
               	str	w5, [x1, #0x4]
               	add	x2, x2, #0x2
               	str	w2, [x1, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0xa
               	b.lt	<addr>
               	ldursw	x0, [x29, #-0x24]
               	ldursw	x1, [x29, #-0x20]
               	add	x0, x0, x1
               	ldursw	x1, [x29, #-0x1c]
               	add	x0, x0, x1
               	cmp	w0, #0x837
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x20
               	lsl	x3, x0, #2
               	add	x1, x0, #0x41
               	strb	w1, [x2, x3]
               	add	x2, x2, x3
               	add	x3, x1, #0x1
               	strb	w3, [x2, #0x1]
               	add	x3, x1, #0x2
               	strb	w3, [x2, #0x2]
               	add	x1, x1, #0x3
               	strb	w1, [x2, #0x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x14]
               	ldurb	w1, [x29, #-0x13]
               	add	x0, x0, x1
               	ldurb	w1, [x29, #-0x12]
               	add	x0, x0, x1
               	ldurb	w1, [x29, #-0x11]
               	add	x0, x0, x1
               	cmp	w0, #0x116
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
