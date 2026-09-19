
builtin_frame_address_levels.aarch64:	file format elf64-littleaarch64

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
               	add	x1, x29, #0x0
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x29, #0x0
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x29, #0x0
               	ldr	x1, [x1]
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x29, #0x0
               	ldr	x1, [x1]
               	ldr	x1, [x1]
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x29, #0x0
               	ldr	x1, [x1]
               	ldr	x1, [x1]
               	ldr	x1, [x1]
               	str	x1, [x0]
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret

<f2>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x29, #0x0
               	str	x1, [x0]
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	w0, [x1]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<f1>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x29, #0x0
               	str	x1, [x0]
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	w0, [x1]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x29, #0x0
               	str	x1, [x0]
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x0, [x2]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	cmp	x1, x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x3, [x1]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x4, [x4]
               	cmp	x3, x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x4, [x3]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	x5, [x5]
               	cmp	x4, x5
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x2]
               	ldr	x4, [x0]
               	cmp	x2, x4
               	b.eq	<addr>
               	ldr	x0, [x0]
               	ldr	x2, [x1]
               	cmp	x0, x2
               	b.eq	<addr>
               	ldr	x0, [x1]
               	ldr	x1, [x3]
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
