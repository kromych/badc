
stack_protector_frame_order.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	stur	x16, [x29, #-0x8]
               	mov	x16, #0x0               // =0
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0x28]
               	sub	x0, x29, #0x28
               	sub	x1, x29, #0x20
               	ldrsw	x0, [x0]
               	and	x2, x0, #0xff
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x3, w0
               	strb	w2, [x1, x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	ldrb	w1, [x0]
               	ldrb	w2, [x0, #0xf]
               	add	x1, x1, x2
               	cmp	w1, #0x6
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	ldur	x17, [x29, #-0x8]
               	cmp	x16, x17
               	b.eq	<addr>
               	bl	<addr>
               	mov	x16, #0x0               // =0
               	mov	x17, #0x0               // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x9                // =9
               	str	w1, [x0]
               	add	x1, x0, #0x4
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w0
               	mov	x3, #0x4                // =4
               	strb	w3, [x1, x2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	ldrsw	x1, [x0]
               	ldrb	w0, [x0, #0xb]
               	add	x0, x1, x0
               	cmp	w0, #0xd
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	ldur	x17, [x29, #-0x8]
               	cmp	x16, x17
               	b.eq	<addr>
               	bl	<addr>
               	mov	x16, #0x0               // =0
               	mov	x17, #0x0               // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	ldur	x17, [x29, #-0x8]
               	cmp	x16, x17
               	b.eq	<addr>
               	bl	<addr>
               	mov	x16, #0x0               // =0
               	mov	x17, #0x0               // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
