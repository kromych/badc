
builtin_return_address_levels.aarch64:	file format elf64-littleaarch64

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

<f3>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x30, [x29, #0x8]
               	xpaclri
               	mov	x1, x30
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x30, [x29, #0x8]
               	xpaclri
               	mov	x1, x30
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x29, #0x0
               	ldr	x1, [x1]
               	ldr	x30, [x1, #0x8]
               	xpaclri
               	mov	x1, x30
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x29, #0x0
               	ldr	x1, [x1]
               	ldr	x1, [x1]
               	ldr	x30, [x1, #0x8]
               	xpaclri
               	mov	x1, x30
               	str	x1, [x0]
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret

<f2>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x30, [x29, #0x8]
               	xpaclri
               	mov	x1, x30
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adr	x1, <addr>
               	str	x1, [x0]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	bl	<addr>
               	str	w0, [x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adr	x1, <addr>
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<f1>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x30, [x29, #0x8]
               	xpaclri
               	mov	x1, x30
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adr	x1, <addr>
               	str	x1, [x0]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	bl	<addr>
               	str	w0, [x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adr	x1, <addr>
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adr	x1, <addr>
               	str	x1, [x0]
               	bl	<addr>
               	stur	w0, [x29, #-0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	w0, [x1]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adr	x0, <addr>
               	str	x0, [x5]
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	cmp	x2, x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x4, [x4]
               	cmp	x3, x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x4, [x0]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	x6, [x6]
               	cmp	x3, x4
               	mov	x3, #0x0                // =0
               	b.hs	<addr>
               	b	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x4, [x1]
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	x6, [x6]
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	ldr	x7, [x7]
               	cmp	x6, x4
               	b.hs	<addr>
               	b	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x4, [x2]
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	x6, [x6]
               	ldr	x5, [x5]
               	cmp	x6, x4
               	b.hs	<addr>
               	b	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x4, [x0]
               	ldr	x5, [x1]
               	cmp	x4, x5
               	mov	x5, #0x1                // =1
               	stur	x5, [x29, #-0x8]
               	b.eq	<addr>
               	ldr	x1, [x1]
               	ldr	x4, [x2]
               	cmp	x1, x4
               	cset	x1, eq
               	stur	x1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	stur	x1, [x29, #-0x8]
               	cbnz	x1, <addr>
               	ldr	x0, [x0]
               	ldr	x1, [x2]
               	cmp	x0, x1
               	cset	x0, eq
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x4, x6
               	cset	x4, ls
               	cbnz	w4, <addr>
               	b	<addr>
               	cmp	x4, x7
               	cset	x4, ls
               	cbnz	w4, <addr>
               	b	<addr>
               	cmp	x4, x5
               	cset	x4, ls
               	cbnz	w4, <addr>
               	b	<addr>
               	mov	x4, x3
               	b	<addr>
               	mov	x4, x3
               	b	<addr>
               	mov	x4, x3
               	b	<addr>
