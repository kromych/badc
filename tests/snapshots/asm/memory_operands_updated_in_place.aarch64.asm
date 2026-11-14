
memory_operands_updated_in_place.aarch64:	file format elf64-littleaarch64

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

<hold>:
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	ret

<drop_ref>:
               	ldrsw	x1, [x0]
               	sub	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, x1
               	cmp	w0, #0x0
               	cset	x0, le
               	ret

<bump>:
               	ldrb	w1, [x0]
               	add	x1, x1, #0x12c
               	strb	w1, [x0]
               	ret

<retag>:
               	sxth	x1, w1
               	ldrsh	x2, [x0, #0x4]
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x4]
               	ret

<update>:
               	ldr	x3, [x0, #0x8]
               	and	x1, x3, x1
               	orr	x1, x1, #0x100
               	eor	x1, x1, x2
               	str	x1, [x0, #0x8]
               	ldrb	w1, [x0, #0x6]
               	mov	x17, #0x81              // =129
               	eor	x1, x1, x17
               	strb	w1, [x0, #0x6]
               	ldrb	w1, [x0, #0x6]
               	orr	x1, x1, #0x2
               	strb	w1, [x0, #0x6]
               	ret

<add_from>:
               	add	x1, x1, #0x2
               	ldrh	w3, [x0, w1, sxtw #1]
               	and	x2, x2, #0xffff
               	add	x2, x3, x2
               	strh	w2, [x0, w1, sxtw #1]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	bl	<addr>
               	sub	x0, x29, #0x10
               	bl	<addr>
               	sub	x0, x29, #0x10
               	ldursw	x1, [x29, #-0x10]
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	w0, <addr>
               	sub	x0, x29, #0x10
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	bl	<addr>
               	cbz	w0, <addr>
               	ldursw	x0, [x29, #-0x10]
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfa               // =250
               	sturb	w0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	ldurb	w0, [x29, #-0x20]
               	cmp	w0, #0x26
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0xc                // =12
               	bl	<addr>
               	sub	x0, x29, #0x10
               	ldursh	x1, [x29, #-0xc]
               	cmn	w1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xff               // =255
               	movk	x1, #0xff, lsl #16
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0x1fa             // =506
               	movk	x17, #0xff, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0xa]
               	cmp	w0, #0x8e
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	ldurh	w0, [x29, #-0x14]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
