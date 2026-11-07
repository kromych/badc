
file_scope_asm_rept_type_size.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0, #0x1]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x2]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x3]
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0, #0x4]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x5]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x6]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x7]
               	cmp	w0, #0x7
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp], #0x10
               	ret
  <addr>: 04 04 04 07  	.word	0x07040404
  <addr>: 07 07 07 07  	.word	0x07070707

<rept_run_len>:
  <addr>: 08 00 00 00  	.word	0x00000008
