
char_constant_signedness.aarch64:	file format elf64-littleaarch64

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

<pick>:
               	ldrb	w0, [x0]
               	cmp	w0, #0x80
               	b.lo	<addr>
               	cmp	w0, #0xff
               	b.lo	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	w0, #0x80
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	ret
               	cmp	w0, #0x28
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret

<main>:
               	str	x19, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x80               // =128
               	stur	w0, [x29, #-0x10]
               	ldursw	x1, [x29, #-0x10]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0x80              // =128
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x1, #0xff               // =255
               	stur	w1, [x29, #-0x10]
               	ldursw	x1, [x29, #-0x10]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0xff              // =255
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	stur	w0, [x29, #-0x10]
               	sub	x0, x29, #0x8
               	ldursw	x1, [x29, #-0x10]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x0, #0xff               // =255
               	stur	w0, [x29, #-0x10]
               	sub	x0, x29, #0x8
               	ldursw	x1, [x29, #-0x10]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
