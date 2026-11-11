
returned_aggregate_read_past_its_lifetime_marker.aarch64:	file format elf64-littleaarch64

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

<k>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxth	x1, w1
               	sxtb	x2, w2
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	adrp	x1, <page>
               	strb	wzr, [x1, #0x48]
               	strb	wzr, [x1, #0x48]
               	ldrb	w1, [x1, #0x48]
               	cmp	w1, #0x7
               	b.eq	<addr>
               	stur	wzr, [x29, #-0x10]
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	ldr	x3, [x0, #0x18]
               	sub	x1, x29, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	adrp	x2, <page>
               	mov	x0, #0x0                // =0
               	strb	w0, [x2, #0x48]
               	strb	w0, [x2, #0x48]
               	ldrb	w2, [x2, #0x48]
               	cmp	w2, #0x7
               	ldr	x1, [x1]
               	str	x1, [x3]
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	cmp	x1, #0x3
               	b.ne	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
