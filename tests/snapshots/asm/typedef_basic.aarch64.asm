
typedef_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x30
               	mov	x2, #0x7                // =7
               	str	w2, [x1]
               	sub	x1, x29, #0x30
               	mov	x2, #0x0                // =0
               	str	x2, [x1, #0x8]
               	sub	x1, x29, #0x38
               	mov	x2, #0xb                // =11
               	str	w2, [x1]
               	sub	x1, x29, #0x38
               	mov	x2, #0x16               // =22
               	str	w2, [x1, #0x4]
               	sub	x1, x29, #0x48
               	mov	x2, #0x1                // =1
               	str	w2, [x1]
               	sub	x1, x29, #0x48
               	mov	x2, #0x2                // =2
               	str	w2, [x1, #0x4]
               	sub	x1, x29, #0x48
               	mov	x2, #0x3                // =3
               	str	w2, [x1, #0x8]
               	b	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x0]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	ldrsw	x0, [x0]
               	sub	x1, x29, #0x38
               	ldrsw	x1, [x1, #0x4]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0x21
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	ldrsw	x0, [x0]
               	sub	x1, x29, #0x48
               	ldrsw	x1, [x1, #0x4]
               	add	x0, x0, x1
               	sub	x1, x29, #0x48
               	ldrsw	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
