
cleanup_handler_name_shadowed_at_exit.aarch64:	file format elf64-littleaarch64

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

<cl>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	ldrsw	x0, [x0]
               	add	x0, x2, x0
               	str	w0, [x1]
               	ret

<on_return>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<on_break>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0x0               // =0
               	mov	x21, x20
               	b	<addr>
               	sub	x0, x29, #0x8
               	bl	<addr>
               	add	x20, x20, #0x1
               	stur	w20, [x29, #-0x8]
               	add	x21, x21, #0x2
               	cmp	w20, #0x2
               	b.ne	<addr>
               	sub	x0, x29, #0x8
               	bl	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret

<at_function_end>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x64               // =100
               	stur	w0, [x29, #-0x8]
               	fmov	d0, #0.50000000
               	fmov	d1, #4.00000000
               	fmul	d0, d0, d1
               	fcvtzs	x20, d0
               	sub	x0, x29, #0x8
               	bl	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	wzr, [x1]
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0xc
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x7
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	orr	x20, x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	wzr, [x0]
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	w0, #0x6
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x3
               	cset	x0, ne
               	orr	x20, x20, x0, lsl #1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	wzr, [x0]
               	bl	<addr>
               	cmp	w0, #0x2
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x64
               	cset	x0, ne
               	orr	x0, x20, x0, lsl #2
               	cmp	w0, #0x0
               	cset	x0, ne
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
