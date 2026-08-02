
arrays_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sub	x0, x29, #0x60
               	add	x0, x0, #0x0
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	sub	x0, x29, #0x60
               	mov	x1, #0x2                // =2
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x60
               	mov	x1, #0x3                // =3
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x60
               	mov	x1, #0x4                // =4
               	str	w1, [x0, #0xc]
               	sub	x0, x29, #0x60
               	mov	x1, #0x5                // =5
               	str	w1, [x0, #0x10]
               	sub	x3, x29, #0x60
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	ldrsw	x1, [x3, x2, lsl #2]
               	add	x0, x0, x1
               	add	x1, x2, #0x1
               	sxtw	x1, w1
               	sxtw	x2, w1
               	cmp	x2, #0x5
               	b.lt	<addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x0
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa                // =10
               	str	w1, [x0, #0x4]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x14               // =20
               	str	w1, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1e               // =30
               	str	w1, [x0, #0xc]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x28               // =40
               	str	w1, [x0, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0x8]
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0xc]
               	add	x1, x1, x2
               	ldrsw	x0, [x0, #0x10]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x68               // =104
               	strb	w2, [x0]
               	mov	x2, #0x69               // =105
               	strb	w2, [x0, #0x1]
               	strb	w1, [x0, #0x2]
               	ldrb	w0, [x0]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x69              // =105
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x2]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	add	x0, x0, #0x0
               	mov	x1, #0x41               // =65
               	strb	w1, [x0]
               	sub	x0, x29, #0x48
               	mov	x1, #0x42               // =66
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x48
               	mov	x1, #0x43               // =67
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x48
               	mov	x1, #0x44               // =68
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x48
               	mov	x1, #0x45               // =69
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x48
               	mov	x1, #0x46               // =70
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0x48
               	mov	x1, #0x47               // =71
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0x48
               	mov	x1, #0x48               // =72
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0x48
               	ldrb	w0, [x0]
               	mov	x17, #0x41              // =65
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	ldrb	w0, [x0, #0x7]
               	mov	x17, #0x48              // =72
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	add	x0, x0, #0x8
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
