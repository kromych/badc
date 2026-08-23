
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
               	sub	x3, x29, #0x18
               	add	x0, x3, #0x0
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	mov	x0, #0x2                // =2
               	str	w0, [x3, #0x4]
               	mov	x0, #0x3                // =3
               	str	w0, [x3, #0x8]
               	mov	x0, #0x4                // =4
               	str	w0, [x3, #0xc]
               	mov	x0, #0x5                // =5
               	str	w0, [x3, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	ldrsw	x0, [x3, x2, lsl #2]
               	add	x1, x1, x0
               	add	x0, x2, #0x1
               	sxtw	x0, w0
               	sxtw	x2, w0
               	cmp	x2, #0x5
               	b.lt	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x0
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0xa                // =10
               	str	w2, [x0, #0x4]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x14               // =20
               	str	w2, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x1e               // =30
               	str	w2, [x0, #0xc]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x28               // =40
               	str	w2, [x0, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	ldrsw	x3, [x0, #0x4]
               	add	x2, x2, x3
               	ldrsw	x3, [x0, #0x8]
               	add	x2, x2, x3
               	ldrsw	x3, [x0, #0xc]
               	add	x2, x2, x3
               	ldrsw	x0, [x0, #0x10]
               	add	x0, x2, x0
               	sxtw	x0, w0
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x68               // =104
               	strb	w2, [x0]
               	mov	x2, #0x69               // =105
               	strb	w2, [x0, #0x1]
               	strb	w1, [x0, #0x2]
               	ldrb	w0, [x0]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x69              // =105
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x2]
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	ldrsw	x2, [x0]
               	ldrsw	x3, [x0, #0x4]
               	add	x2, x2, x3
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x2, x0
               	sxtw	x0, w0
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
