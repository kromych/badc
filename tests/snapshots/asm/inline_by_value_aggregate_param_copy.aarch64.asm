
inline_by_value_aggregate_param_copy.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	strh	wzr, [x0]
               	mov	x1, #0x11               // =17
               	sturb	w1, [x29, #-0x8]
               	mov	x1, #0x8c               // =140
               	sturb	w1, [x29, #-0x8]
               	mov	x1, #0x7                // =7
               	sturb	w1, [x29, #-0x8]
               	adrp	x1, <page>
               	str	x0, [x1, #0x20]
               	ldurb	w1, [x29, #-0x8]
               	mov	x2, #0x63               // =99
               	strb	w2, [x0]
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x8]
               	cmp	w0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	sturb	w0, [x29, #-0x8]
               	mov	x0, #0x3                // =3
               	sturb	w0, [x29, #-0x8]
               	mov	x0, #0x37               // =55
               	sturb	w0, [x29, #-0x8]
               	adrp	x0, <page>
               	mov	x1, #0x4d               // =77
               	strb	w1, [x0, #0x28]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
