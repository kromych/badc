
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
               	sxth	x1, w1
               	sxtb	x2, w2
               	mov	x0, #0x3                // =3
               	adrp	x1, <page>
               	strb	wzr, [x1, #0x48]
               	ldrb	w1, [x1, #0x48]
               	cmp	w1, #0x7
               	b.eq	<addr>
               	ret
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	ldr	x3, [x0, #0x10]
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	adrp	x1, <page>
               	mov	x2, #0x0                // =0
               	strb	w2, [x1, #0x48]
               	ldrb	w1, [x1, #0x48]
               	cmp	w1, #0x7
               	ldr	x0, [x0]
               	str	x0, [x3]
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	ldr	x0, [x0, #0x30]
               	cmp	x0, #0x3
               	csel	x0, x2, x1, eq
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
