
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
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	sub	x0, x29, #0x8
               	strb	wzr, [x0]
               	mov	x20, #0x0               // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x18              // =24
               	mul	x22, x20, x17
               	add	x21, x0, x22
               	ldr	x0, [x21]
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	ldr	x2, [x21, #0x8]
               	bl	<addr>
               	cbz	w0, <addr>
               	ldr	x21, [x21]
               	mov	x0, x21
               	bl	<addr>
               	sub	x0, x0, #0x1
               	ldrb	w0, [x21, x0]
               	mov	x17, #0x2f              // =47
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x2, x0, x22
               	ldr	x0, [x2]
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	ldr	x2, [x2, #0x10]
               	bl	<addr>
               	cbz	w0, <addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x8
               	b.lo	<addr>
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
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	lsl	x0, x20, #1
               	add	x0, x0, #0x2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	lsl	x0, x20, #1
               	add	x0, x0, #0x1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
