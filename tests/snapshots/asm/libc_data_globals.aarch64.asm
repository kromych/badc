
libc_data_globals.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x8]
               	cbz	x1, <addr>
               	ldr	x20, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x10]
               	cbz	x1, <addr>
               	ldr	x21, [x0, #0x10]
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x30]
               	cbz	x1, <addr>
               	ldr	x0, [x0, #0x30]
               	cbnz	x20, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	cbnz	x21, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x8]
               	cbz	x1, <addr>
               	ldr	x1, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x10]
               	cbz	x1, <addr>
               	ldr	x0, [x0, #0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x0]
               	str	x0, [x1, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x10]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x0]
               	str	x0, [x1, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x8]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	ldr	x0, [x0]
               	str	x0, [x1, #0x30]
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x0]
               	str	x0, [x1, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x21, [x0, #0x10]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x0]
               	str	x0, [x1, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0, #0x8]
               	b	<addr>
