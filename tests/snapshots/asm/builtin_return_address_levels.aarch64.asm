
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
               	str	x19, [sp, #-0x20]!
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
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret

<f2>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
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
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret

<f1>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
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
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret

<main>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adr	x0, <addr>
               	str	x0, [x20]
               	bl	<addr>
               	stur	w0, [x29, #-0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sxtw	x0, w0
               	str	w0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adr	x1, <addr>
               	str	x1, [x0]
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	b	<addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	b	<addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldr	x2, [x20]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	b	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x0, x1
               	mov	x1, #0x1                // =1
               	stur	x1, [x29, #-0x8]
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	stur	x0, [x29, #-0x8]
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	cmp	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b.hs	<addr>
               	cmp	x1, x2
               	cset	x1, ls
               	sxtw	x1, w1
               	b	<addr>
               	cmp	x2, x1
               	mov	x1, x0
               	b.hs	<addr>
               	cmp	x1, x3
               	cset	x1, ls
               	sxtw	x1, w1
               	b	<addr>
               	cmp	x2, x1
               	b.hs	<addr>
               	cmp	x1, x3
               	cset	x0, ls
               	sxtw	x0, w0
               	b	<addr>
