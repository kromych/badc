
three_dim_array_indexing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	ldrb	w2, [x0, #0x1]
               	add	x1, x1, x2
               	ldrb	w2, [x0, #0x2]
               	add	x1, x1, x2
               	ldrb	w2, [x0, #0x3]
               	add	x1, x1, x2
               	sxtw	x2, w1
               	sxtw	x1, w2
               	cmp	x1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	add	x1, x0, #0x8
               	ldrb	w2, [x1]
               	ldrb	w3, [x1, #0x1]
               	add	x2, x2, x3
               	ldrb	w3, [x1, #0x2]
               	add	x2, x2, x3
               	ldrb	w1, [x1, #0x3]
               	add	x1, x2, x1
               	sxtw	x2, w1
               	sxtw	x1, w2
               	cmp	x1, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	add	x1, x0, #0x10
               	ldrb	w2, [x1]
               	ldrb	w3, [x1, #0x1]
               	add	x2, x2, x3
               	ldrb	w3, [x1, #0x2]
               	add	x2, x2, x3
               	ldrb	w1, [x1, #0x3]
               	add	x1, x2, x1
               	sxtw	x2, w1
               	sxtw	x1, w2
               	cmp	x1, #0x4a
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	ldrb	w1, [x0]
               	mov	x17, #0x1               // =1
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	ldrb	w1, [x0, #0xb]
               	mov	x17, #0xc               // =12
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	ldrb	w1, [x0, #0x17]
               	mov	x17, #0x18              // =24
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	ldrb	w1, [x0, #0xc]
               	ldrb	w2, [x0]
               	sub	x1, x1, x2
               	sxtw	x1, w1
               	cmp	x1, #0xc
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	ldrb	w1, [x0, #0x4]
               	ldrb	w0, [x0]
               	sub	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
