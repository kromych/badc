
arrays_basic.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	sub	x2, x29, #0x18
               	mov	x0, #0x1                // =1
               	movk	x0, #0x2, lsl #32
               	stur	x0, [x29, #-0x18]
               	mov	x0, #0x3                // =3
               	movk	x0, #0x4, lsl #32
               	stur	x0, [x29, #-0x10]
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldrsw	x3, [x2, x0, lsl #2]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	cmp	w1, #0xf
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, #0xa00000000        // =42949672960
               	str	x2, [x1]
               	mov	x2, #0x14               // =20
               	movk	x2, #0x1e, lsl #32
               	str	x2, [x1, #0x8]
               	mov	x2, #0x28               // =40
               	str	w2, [x1, #0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x6968             // =26984
               	strh	w2, [x1]
               	strb	w0, [x1, #0x2]
               	ldrb	w2, [x1, #0x1]
               	cmp	w2, #0x69
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x1, #0x2]
               	cbz	w1, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x1, [x29, #-0x10]
               	ldursw	x2, [x29, #-0xc]
               	add	x1, x1, x2
               	ldursw	x2, [x29, #-0x8]
               	add	x1, x1, x2
               	cmp	w1, #0xc
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
