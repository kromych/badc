
aio_read_write_completes.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x310
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	sub	x0, x29, #0x2b8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	w16, [x1, #0x10]
               	str	w16, [x0, #0x10]
               	ldrb	w16, [x1, #0x14]
               	strb	w16, [x0, #0x14]
               	bl	<addr>
               	mov	x23, x0
               	cmp	w23, #0x0
               	b.ge	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x2b8
               	bl	<addr>
               	sub	x0, x29, #0x1f8
               	mov	x1, #0x0                // =0
               	mov	x2, #0xa8               // =168
               	bl	<addr>
               	sub	x0, x29, #0x1f8
               	str	w23, [sp, #0x118]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [sp, #0x128]
               	mov	x1, #0xc                // =12
               	str	x1, [sp, #0x130]
               	str	xzr, [sp, #0x198]
               	mov	x21, #0x1               // =1
               	str	w21, [sp, #0x144]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x1f8
               	sub	x0, x29, #0x2c8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x22, x29, #0x2e0
               	str	x20, [sp, #0x30]
               	b	<addr>
               	sub	x2, x29, #0x2c8
               	mov	x0, x22
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x73
               	b.eq	<addr>
               	cbnz	w0, <addr>
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x150
               	mov	x1, #0x0                // =0
               	mov	x2, #0xa8               // =168
               	bl	<addr>
               	sub	x0, x29, #0x150
               	str	w23, [sp, #0x1c0]
               	sub	x1, x29, #0x2f0
               	str	x1, [sp, #0x1d0]
               	mov	x1, #0x8                // =8
               	str	x1, [sp, #0x1d8]
               	stur	xzr, [x29, #-0xd0]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x150
               	sub	x21, x29, #0x2c8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x21]
               	sub	x22, x29, #0x2e0
               	str	x20, [sp, #0x30]
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x22
               	mov	x2, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x73
               	b.eq	<addr>
               	cbnz	w0, <addr>
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x8
               	b.ne	<addr>
               	sub	x0, x29, #0x2f0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	mov	x1, #0x0                // =0
               	mov	x2, #0xa8               // =168
               	bl	<addr>
               	stur	w23, [x29, #-0xa8]
               	sub	x0, x29, #0x2e8
               	stur	x0, [x29, #-0x98]
               	mov	x0, #0x4                // =4
               	stur	x0, [x29, #-0x90]
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0x28]
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0xa4]
               	sub	x0, x29, #0x2a0
               	mov	x2, #0xa8               // =168
               	bl	<addr>
               	sub	x3, x29, #0x2a0
               	str	w23, [sp, #0x70]
               	mov	x2, #0x2                // =2
               	str	w2, [sp, #0x74]
               	sub	x1, x29, #0x2d8
               	mov	x0, #0x0                // =0
               	sub	x4, x29, #0xa8
               	str	x4, [sp, #0x38]
               	str	x3, [sp, #0x40]
               	mov	x3, x0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xa8
               	bl	<addr>
               	cmp	x0, #0x4
               	b.ne	<addr>
               	sub	x0, x29, #0x2e8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1000             // =4096
               	movk	x0, #0x10, lsl #16
               	sub	x1, x29, #0x1f8
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x1f8
               	sub	x21, x29, #0x2c8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x21]
               	sub	x22, x29, #0x2e0
               	str	x20, [sp, #0x30]
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x22
               	mov	x2, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x73
               	b.eq	<addr>
               	cbnz	w0, <addr>
               	mov	x0, x20
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x23
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x2a0
               	bl	<addr>
               	mov	x0, x23
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
