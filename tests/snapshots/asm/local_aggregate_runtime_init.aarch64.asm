
local_aggregate_runtime_init.aarch64:	file format elf64-littleaarch64

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

<opaque>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x18
               	stp	xzr, xzr, [x0]
               	str	xzr, [x0, #0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	stur	w2, [x29, #-0x18]
               	mov	x2, #0x6f68             // =28520
               	movk	x2, #0x616c, lsl #16
               	stur	w2, [x29, #-0x14]
               	stur	wzr, [x29, #-0x10]
               	sturh	wzr, [x29, #-0xc]
               	stur	x1, [x29, #-0x8]
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0, #0x4]
               	cmp	w1, #0x68
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x5]
               	cmp	w1, #0x6f
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x6]
               	cmp	w1, #0x6c
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x7]
               	cmp	w1, #0x61
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0, #0x8]
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0xd]
               	cbz	w1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0]
               	sub	x0, x29, #0x28
               	stur	w1, [x29, #-0x28]
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x10]
               	stur	w1, [x29, #-0x24]
               	mov	x1, #0x5                // =5
               	stur	w1, [x29, #-0x20]
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w1, [x0]
               	cmp	w1, #0x6f
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x1]
               	cmp	w0, #0x6b
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
