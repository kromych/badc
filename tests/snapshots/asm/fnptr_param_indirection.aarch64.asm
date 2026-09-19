
fnptr_param_indirection.aarch64:	file format elf64-littleaarch64

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

<inc>:
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<dbl>:
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x0, [x1]
               	ldur	x1, [x29, #-0x8]
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	ldur	x1, [x29, #-0x8]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0xb
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	ldr	x1, [x1]
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x14
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x0, [x1]
               	ldur	x1, [x29, #-0x8]
               	cmp	x1, x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldur	x1, [x29, #-0x8]
               	mov	x9, x1
               	blr	x9
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
