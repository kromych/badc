
standard_streams_are_objects.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	bl	<addr>
               	mov	x20, x0
               	cbnz	x20, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x21, [x0]
               	str	x20, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2a               // =42
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x21               // =33
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x21
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	str	x21, [x0]
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	mov	x1, #0x10               // =16
               	mov	x2, x20
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, x20
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x1, #0x0                // =0
               	mov	x2, #0xa                // =10
               	cmp	x0, x21
               	csel	x0, x1, x2, eq
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
