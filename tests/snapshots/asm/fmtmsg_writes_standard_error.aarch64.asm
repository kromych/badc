
fmtmsg_writes_standard_error.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x150]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x140]
               	add	x29, sp, #0x140
               	sub	x0, x29, #0x118
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.ge	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x21, x0
               	mov	x1, #0x2                // =2
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x14a              // =330
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, #0x100              // =256
               	mov	x1, #0x0                // =0
               	mov	x2, #0x4                // =4
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x4, x1
               	mov	x5, x1
               	bl	<addr>
               	mov	x23, x0
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	bl	<addr>
               	mov	x1, #0x2                // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	sub	x1, x29, #0x100
               	mov	x2, #0xff               // =255
               	mov	x3, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x118
               	bl	<addr>
               	cbnz	w22, <addr>
               	cbz	w23, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	cmp	x21, #0x0
               	b.ge	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	sub	x0, x29, #0x100
               	strb	wzr, [x0, x21]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, #0x4                // =4
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x0
               	csel	x0, x1, x2, ne
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
