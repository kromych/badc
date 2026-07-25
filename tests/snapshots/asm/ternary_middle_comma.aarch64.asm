
ternary_middle_comma.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	mov	x1, #0x2a               // =42
               	strb	w1, [x0]
               	mov	x0, #0x1                // =1
               	sub	x0, x29, #0x20
               	ldrb	w0, [x0]
               	mov	x17, #0x2a              // =42
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	sub	x2, x29, #0x20
               	ldrb	w2, [x2]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	ret
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x18
               	mov	x1, #0x2a               // =42
               	strb	w1, [x0]
               	mov	x0, #0x1                // =1
               	sub	x0, x29, #0x18
               	ldrb	w0, [x0]
               	mov	x17, #0x2a              // =42
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	sub	x2, x29, #0x18
               	ldrb	w2, [x2]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	ret
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	mov	x1, #0x2a               // =42
               	strb	w1, [x0]
               	mov	x0, #0x1                // =1
               	sub	x0, x29, #0x10
               	ldrb	w0, [x0]
               	mov	x17, #0x2a              // =42
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	sub	x2, x29, #0x10
               	ldrb	w2, [x2]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	ret
               	mov	x3, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x1, #0x3                // =3
               	mov	x0, #0x6                // =6
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x63               // =99
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x63               // =99
               	sub	x2, x29, #0x8
               	ldrb	w2, [x2]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	ret
