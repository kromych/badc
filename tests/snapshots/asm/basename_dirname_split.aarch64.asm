
basename_dirname_split.aarch64:	file format elf64-littleaarch64

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

<splits_to>:
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x20, x1
               	mov	x21, x2
               	sub	x1, x29, #0x40
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sub	x0, x29, #0x40
               	blr	x20
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x1, eq
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	strb	wzr, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	lsl	x0, x0, #1
               	add	x0, x0, #0x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	lsl	x0, x0, #1
               	add	x0, x0, #0x2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x7                // =7
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x7                // =7
               	b	<addr>
               	sub	x0, x29, #0x8
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x64               // =100
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x65               // =101
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
