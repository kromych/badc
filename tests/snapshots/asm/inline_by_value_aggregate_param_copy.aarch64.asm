
inline_by_value_aggregate_param_copy.aarch64:	file format elf64-littleaarch64

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

<via_param_write>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	sub	x20, x29, #0x10
               	mov	x0, #0x0                // =0
               	strh	w0, [x20]
               	mov	x0, #0x11               // =17
               	strb	w0, [x20]
               	ldrb	w0, [x20]
               	ldrb	w1, [x20]
               	mov	x17, #0x4477            // =17527
               	movk	x17, #0x5f, lsl #16
               	add	x1, x1, x17
               	lsr	x1, x1, #7
               	add	x1, x1, #0x3
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x20]
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0x11              // =17
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldrb	w0, [x20]
               	mov	x17, #0x8c              // =140
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x7                // =7
               	strb	w0, [x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x20, [x0]
               	ldrb	w0, [x20]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x2, #0x63               // =99
               	strb	w2, [x1]
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldrb	w0, [x20]
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x21, #0x8               // =8
               	strb	w21, [x20]
               	mov	x0, x20
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldrb	w0, [x20]
               	mov	x17, #0x8               // =8
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x3                // =3
               	strb	w0, [x20]
               	sub	x0, x29, #0x10
               	ldrb	w2, [x0]
               	mov	x1, #0x37               // =55
               	strb	w1, [x0]
               	mov	x17, #0xff              // =255
               	and	x1, x2, x17
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	add	x1, x1, x2
               	sxtw	x1, w1
               	cmp	x1, #0x21
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldrb	w0, [x0]
               	mov	x17, #0x37              // =55
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x4                // =4
               	strb	w1, [x0]
               	ldrb	w0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4d               // =77
               	strb	w2, [x1]
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	sxtw	x0, w0
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	mov	x17, #0x4d              // =77
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
