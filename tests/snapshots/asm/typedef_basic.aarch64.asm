
typedef_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	sxtw	x0, w0
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	x0, #0x64               // =100
               	mov	x1, #0x41               // =65
               	mov	x2, #0x2d2              // =722
               	movk	x2, #0x4996, lsl #16
               	adrp	x3, <page>
               	add	x3, x3, #0xd0
               	sub	x4, x29, #0x30
               	mov	x5, #0x7                // =7
               	str	w5, [x4]
               	sub	x4, x29, #0x30
               	mov	x5, #0x0                // =0
               	str	x5, [x4, #0x8]
               	sub	x4, x29, #0x38
               	mov	x5, #0xb                // =11
               	str	w5, [x4]
               	sub	x4, x29, #0x38
               	mov	x5, #0x16               // =22
               	str	w5, [x4, #0x4]
               	sub	x4, x29, #0x48
               	mov	x5, #0x1                // =1
               	str	w5, [x4]
               	sub	x4, x29, #0x48
               	mov	x5, #0x2                // =2
               	str	w5, [x4, #0x4]
               	sub	x4, x29, #0x48
               	mov	x5, #0x3                // =3
               	str	w5, [x4, #0x8]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0xa5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x3]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
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
               	sub	x3, x29, #0x38
               	ldrsw	x3, [x3, #0x4]
               	add	x0, x0, x3
               	sxtw	x0, w0
               	cmp	x0, #0x21
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	ldrsw	x0, [x0]
               	sub	x3, x29, #0x48
               	ldrsw	x3, [x3, #0x4]
               	add	x0, x0, x3
               	sxtw	x0, w0
               	sub	x3, x29, #0x48
               	ldrsw	x3, [x3, #0x8]
               	add	x0, x0, x3
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x2d2             // =722
               	movk	x17, #0x4996, lsl #16
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x1, #0x41
               	b.eq	<addr>
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
