
streams_write_and_read_back_a_file.aarch64:	file format elf64-littleaarch64

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
               	cmp	w0, #0x2
               	b.lt	<addr>
               	stp	x20, x21, [sp, #-0x190]!
               	stp	x29, x30, [sp, #0x180]
               	add	x29, sp, #0x180
               	mov	x21, x1
               	ldr	x0, [x21, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	cbnz	x20, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x180]
               	ldp	x20, x21, [sp], #0x190
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2a               // =42
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, #0x78               // =120
               	mov	x1, x20
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x9                // =9
               	mov	x3, x20
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	ldr	x0, [x21, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	ldr	x0, [x21, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x120
               	mov	x1, #0x20               // =32
               	mov	x2, x20
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x120
               	mov	x1, #0x7                // =7
               	mov	x2, x20
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x120
               	mov	x1, #0x20               // =32
               	mov	x2, x20
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	str	x0, [sp, #0x28]
               	mov	x0, #0x59               // =89
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	str	x0, [sp, #0x20]
               	mov	x0, x20
               	bl	<addr>
               	mov	x3, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [sp, #0x28]
               	ldr	x2, [sp, #0x20]
               	bl	<addr>
               	sub	x0, x29, #0x120
               	mov	x1, #0x20               // =32
               	mov	x2, x20
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	str	xzr, [sp, #0x38]
               	str	wzr, [sp, #0x40]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x148
               	sub	x3, x29, #0x140
               	mov	x0, x20
               	bl	<addr>
               	str	x0, [sp, #0x28]
               	ldr	d16, [sp, #0x38]
               	str	d16, [sp, #0x20]
               	ldrsw	x17, [sp, #0x40]
               	str	x17, [sp, #0x18]
               	mov	x0, x20
               	bl	<addr>
               	mov	x3, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [sp, #0x20]
               	ldr	x1, [sp, #0x28]
               	ldr	x2, [sp, #0x18]
               	bl	<addr>
               	str	xzr, [sp, #0x48]
               	str	xzr, [sp, #0x50]
               	sub	x0, x29, #0x138
               	sub	x1, x29, #0x130
               	mov	x2, x20
               	bl	<addr>
               	str	x0, [sp, #0x28]
               	ldr	x17, [sp, #0x48]
               	str	x17, [sp, #0x20]
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x3, ne
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [sp, #0x28]
               	ldr	x2, [sp, #0x20]
               	bl	<addr>
               	sub	x0, x29, #0x138
               	sub	x1, x29, #0x130
               	mov	x2, x20
               	bl	<addr>
               	str	x0, [sp, #0x28]
               	ldr	x17, [sp, #0x48]
               	str	x17, [sp, #0x20]
               	mov	x0, x20
               	bl	<addr>
               	str	x0, [sp, #0x18]
               	mov	x0, x20
               	bl	<addr>
               	mov	x4, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [sp, #0x28]
               	ldr	x2, [sp, #0x20]
               	ldr	x3, [sp, #0x18]
               	bl	<addr>
               	ldr	x0, [sp, #0x48]
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x128
               	str	xzr, [x0]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, x20
               	bl	<addr>
               	str	x0, [sp, #0x28]
               	mov	x1, #-0x4               // =-4
               	mov	x2, #0x2                // =2
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	str	x0, [sp, #0x20]
               	mov	x0, x20
               	bl	<addr>
               	mov	x4, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x2, x29, #0x128
               	ldr	x1, [sp, #0x28]
               	ldr	x3, [sp, #0x20]
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	str	x0, [sp, #0x28]
               	mov	x0, x20
               	bl	<addr>
               	mov	x2, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [sp, #0x28]
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	bl	<addr>
               	str	wzr, [x0]
               	sub	x0, x29, #0x100
               	mov	x1, #0x100              // =256
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x21, #0x8]
               	bl	<addr>
               	sub	x0, x29, #0x100
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x20, eq
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2
               	cset	x2, eq
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x180]
               	ldp	x20, x21, [sp], #0x190
               	ret
               	mov	x0, #0x2                // =2
               	ret
