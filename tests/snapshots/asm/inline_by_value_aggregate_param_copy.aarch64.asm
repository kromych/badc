
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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	strh	wzr, [x0]
               	mov	x1, #0x11               // =17
               	strb	w1, [x0]
               	ldrb	w1, [x0]
               	mov	x2, #0x8c               // =140
               	strb	w2, [x0]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0x11              // =17
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0]
               	mov	x17, #0x8c              // =140
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x7                // =7
               	strb	w1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x0, [x2]
               	ldrb	w2, [x0]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	mov	x4, #0x63               // =99
               	strb	w4, [x3]
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	sxtw	x2, w2
               	cmp	w2, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w2, [x0]
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	mov	w2, w2
               	cbz	x2, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x8                // =8
               	strb	w2, [x0]
               	ldrb	w3, [x0]
               	mov	x17, #0x8               // =8
               	eor	x3, x3, x17
               	mov	w3, w3
               	cbz	x3, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x3                // =3
               	strb	w3, [x0]
               	ldrb	w3, [x0]
               	ldrb	w4, [x0]
               	mov	x5, #0x37               // =55
               	strb	w5, [x0]
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	mov	x17, #0xa               // =10
               	mul	x3, x3, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	add	x3, x3, x4
               	sxtw	x3, w3
               	cmp	w3, #0x21
               	b.eq	<addr>
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x0]
               	mov	x17, #0x37              // =55
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, x2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x4                // =4
               	strb	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x4d               // =77
               	strb	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	mov	x17, #0x4d              // =77
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
