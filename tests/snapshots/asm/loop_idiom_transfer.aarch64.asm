
loop_idiom_transfer.aarch64:	file format elf64-littleaarch64

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

<fill_bytes>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	sxtw	x1, w1
               	cmp	x1, #0x0
               	b.le	<addr>
               	mov	x2, #0x2                // =2
               	sub	x1, x1, #0x0
               	mov	x16, x2
               	mov	x2, x1
               	mov	x1, x16
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret

<fill_words>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x1, #0x0                // =0
               	mov	x2, #0x28               // =40
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret

<copy_arrays>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x28               // =40
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret

<fill_and_report>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x1
               	sxtw	x20, w20
               	mov	x1, #0x0                // =0
               	cmp	x20, #0x0
               	b.le	<addr>
               	mov	x1, #0x1                // =1
               	sub	x2, x20, #0x0
               	bl	<addr>
               	mov	x1, x20
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x80]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	sub	x0, x29, #0x40
               	mov	x1, #0x7f               // =127
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x10               // =16
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	sub	x2, x29, #0x40
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x3, x2, x1
               	ldrb	w3, [x3]
               	cmp	x3, #0x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x0, <addr>
               	sub	x0, x29, #0x40
               	ldrb	w0, [x0, #0x10]
               	mov	x17, #0x7f              // =127
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x80
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x7f               // =127
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	sub	x2, x29, #0x40
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x3, x2, x1
               	ldrb	w3, [x3]
               	cmp	x3, #0x7f
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x40
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x80
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x7f               // =127
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0xfffd             // =65533
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	sub	x2, x29, #0x40
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x3, x2, x1
               	ldrb	w3, [x3]
               	cmp	x3, #0x7f
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x40
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x80
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x7f               // =127
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x3                // =3
               	strb	w1, [x0]
               	strb	w1, [x0, #0x1]
               	strb	w1, [x0, #0x2]
               	strb	w1, [x0, #0x3]
               	strb	w1, [x0, #0x4]
               	strb	w1, [x0, #0x5]
               	strb	w1, [x0, #0x6]
               	strb	w1, [x0, #0x7]
               	strb	w1, [x0, #0x8]
               	strb	w1, [x0, #0x9]
               	strb	w1, [x0, #0xa]
               	strb	w1, [x0, #0xb]
               	sub	x2, x29, #0x40
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x3, x2, x1
               	ldrb	w3, [x3]
               	cmp	x3, #0x3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0xc
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x0, <addr>
               	sub	x0, x29, #0x40
               	ldrb	w0, [x0, #0xc]
               	mov	x17, #0x7f              // =127
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x80
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x7f               // =127
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x5                // =5
               	strb	w1, [x0, #0x4]
               	strb	w1, [x0, #0x5]
               	strb	w1, [x0, #0x6]
               	strb	w1, [x0, #0x7]
               	strb	w1, [x0, #0x8]
               	strb	w1, [x0, #0x9]
               	strb	w1, [x0, #0xa]
               	strb	w1, [x0, #0xb]
               	sub	x0, x29, #0x40
               	ldrb	w0, [x0, #0x3]
               	mov	x17, #0x7f              // =127
               	eor	x0, x0, x17
               	mov	w1, w0
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x40
               	add	x2, x0, #0x4
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x3, x2, x1
               	ldrb	w3, [x3]
               	cmp	x3, #0x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x40
               	ldrb	w0, [x0, #0xc]
               	mov	x17, #0x7f              // =127
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x80
               	ret
               	mov	x20, #0x0               // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	str	w1, [x0]
               	str	w1, [x0, #0x4]
               	str	w1, [x0, #0x8]
               	str	w1, [x0, #0xc]
               	str	w1, [x0, #0x10]
               	str	w1, [x0, #0x14]
               	str	w1, [x0, #0x18]
               	str	w1, [x0, #0x1c]
               	str	w1, [x0, #0x20]
               	str	w1, [x0, #0x24]
               	str	w1, [x0, #0x28]
               	str	w1, [x0, #0x2c]
               	str	w1, [x0, #0x30]
               	str	w1, [x0, #0x34]
               	str	w1, [x0, #0x38]
               	str	w1, [x0, #0x3c]
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1, x0, lsl #2]
               	cmp	x0, #0xa
               	b.ge	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x2, x1
               	b.eq	<addr>
               	b	<addr>
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	b	<addr>
               	add	x20, x0, #0x1
               	sxtw	x0, w20
               	cmp	x0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x3, x2, x1
               	add	x2, x1, #0x1
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x3]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, x1
               	mov	x3, #0x0                // =0
               	strb	w3, [x2]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x40
               	b.lt	<addr>
               	mov	x0, #0x28               // =40
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, x1
               	ldrb	w3, [x2]
               	cmp	x1, #0x28
               	b.ge	<addr>
               	add	x2, x0, #0x1
               	sxtw	x2, w2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	eor	x2, x3, x2
               	mov	w2, w2
               	cbz	x2, <addr>
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x40
               	b.lt	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x9                // =9
               	bl	<addr>
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x80
               	ret
               	sub	x2, x29, #0x40
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x3, x2, x1
               	ldrb	w3, [x3]
               	cmp	x3, #0x1
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x9
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x0, <addr>
               	sub	x0, x29, #0x40
               	ldrb	w0, [x0, #0x9]
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x80
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x80
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x80
               	ret
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x80
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x80
               	ret
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
