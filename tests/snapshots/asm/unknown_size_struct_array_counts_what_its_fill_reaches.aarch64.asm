
unknown_size_struct_array_counts_what_its_fill_reaches.aarch64:	file format elf64-littleaarch64

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

<is>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	mov	x21, x2
               	mov	x2, #0x3                // =3
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, #0x0                // =0
               	cbnz	x0, <addr>
               	ldrsw	x0, [x20, #0x4]
               	cmp	w0, w21
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret

<file_scope>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x14]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	add	x0, x0, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x14
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x18]
               	ldrb	w0, [x0]
               	mov	x17, #0x71              // =113
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0xc]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	add	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x1c]
               	cbz	w0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	add	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	b	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret

<block_scope>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x1, #0x7                // =7
               	sub	x0, x29, #0x40
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x30
               	stp	xzr, xzr, [x0]
               	mov	x3, #0x61               // =97
               	sturb	w3, [x29, #-0x30]
               	mov	x4, #0x62               // =98
               	sturb	w4, [x29, #-0x2f]
               	sturb	wzr, [x29, #-0x2e]
               	stur	w1, [x29, #-0x2c]
               	mov	x5, #0x64               // =100
               	sturb	w5, [x29, #-0x28]
               	mov	x6, #0x65               // =101
               	sturb	w6, [x29, #-0x27]
               	sturb	wzr, [x29, #-0x26]
               	mov	x2, #0x2                // =2
               	stur	w2, [x29, #-0x24]
               	sub	x7, x29, #0x20
               	stp	xzr, xzr, [x7]
               	sturb	w3, [x29, #-0x20]
               	sturb	w4, [x29, #-0x1f]
               	sturb	wzr, [x29, #-0x1e]
               	mov	x7, #0x1                // =1
               	stur	w7, [x29, #-0x1c]
               	sturb	w5, [x29, #-0x18]
               	sturb	w6, [x29, #-0x17]
               	sturb	wzr, [x29, #-0x16]
               	stur	w1, [x29, #-0x14]
               	sub	x7, x29, #0x10
               	stp	xzr, xzr, [x7]
               	sturb	w3, [x29, #-0x10]
               	sturb	w4, [x29, #-0xf]
               	sturb	wzr, [x29, #-0xe]
               	stur	w1, [x29, #-0xc]
               	sturb	w5, [x29, #-0x8]
               	sturb	w6, [x29, #-0x7]
               	sturb	wzr, [x29, #-0x6]
               	stur	w2, [x29, #-0x4]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x14
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	cbz	w0, <addr>
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x7                // =7
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x20
               	bl	<addr>
               	cbz	w0, <addr>
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x7                // =7
               	bl	<addr>
               	cbz	w0, <addr>
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	b	<addr>
