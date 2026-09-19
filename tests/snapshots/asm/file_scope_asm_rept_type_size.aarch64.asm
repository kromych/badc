
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
               	add	x1, x0, #0x0
               	ldrb	w1, [x1]
               	eor	x1, x1, #0x4
               	cmp	w1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0, #0x1]
               	eor	x1, x1, #0x4
               	cmp	w1, #0x0
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x2]
               	eor	x1, x1, #0x4
               	cmp	w1, #0x0
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x3]
               	eor	x1, x1, #0x7
               	cmp	w1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0, #0x4]
               	eor	x1, x1, #0x7
               	cmp	w1, #0x0
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x5]
               	eor	x1, x1, #0x7
               	cmp	w1, #0x0
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x6]
               	eor	x1, x1, #0x7
               	cmp	w1, #0x0
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x7]
               	eor	x0, x0, #0x7
               	cmp	w0, #0x0
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
               	udf	#0x0

<rept_run>:
               	<unknown>
               	<unknown>

<rept_run_len>:
               	udf	#0x8
