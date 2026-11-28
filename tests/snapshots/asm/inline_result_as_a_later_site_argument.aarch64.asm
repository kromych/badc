
inline_result_as_a_later_site_argument.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<share>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x21, x1
               	mov	x22, x2
               	cmp	w0, #0x3
               	b.lo	<addr>
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, x21
               	bl	<addr>
               	ldr	x20, [x21, #0x8]
               	cbz	x20, <addr>
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x1
               	str	w0, [x20]
               	mov	x0, x21
               	bl	<addr>
               	cbz	x20, <addr>
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x1
               	str	w0, [x20]
               	mov	x0, x22
               	mov	x1, x20
               	bl	<addr>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, x22
               	bl	<addr>
               	ldr	x20, [x22, #0x8]
               	cbz	x20, <addr>
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x1
               	str	w0, [x20]
               	mov	x0, x22
               	bl	<addr>
               	cbz	x20, <addr>
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x1
               	str	w0, [x20]
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<lock>:
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	ret

<unlock>:
               	ldrsw	x1, [x0]
               	sub	x1, x1, #0x1
               	str	w1, [x0]
               	ret

<update>:
               	ldr	x2, [x0, #0x8]
               	str	x1, [x0, #0x8]
               	adrp	x0, <page>
               	str	x1, [x0, #0x20]
               	mov	x0, x2
               	ret

<put>:
               	ret

<main>:
               	str	x20, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x1, x29, #0x28
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w16, [x0]
               	str	w16, [x1]
               	sub	x0, x29, #0x20
               	stp	xzr, xzr, [x0]
               	stur	wzr, [x29, #-0x20]
               	stur	x1, [x29, #-0x18]
               	sub	x1, x29, #0x10
               	stp	xzr, xzr, [x1]
               	bl	<addr>
               	ldur	x20, [x29, #-0x18]
               	cbz	x20, <addr>
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x1
               	str	w0, [x20]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	cbz	x20, <addr>
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x1
               	str	w0, [x20]
               	mov	x1, x20
               	sub	x0, x29, #0x10
               	bl	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	sub	x1, x29, #0x28
               	cmp	x0, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	sub	x1, x29, #0x28
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	ldursw	x0, [x29, #-0x28]
               	cmp	w0, #0x3
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x20]
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
