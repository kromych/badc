
always_inline_frame_address.aarch64:	file format elf64-littleaarch64

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

<inner>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x1, x29, #0x0
               	str	x1, [x0, #0x40]
               	adrp	x0, <page>
               	add	x1, x29, #0x0
               	str	x1, [x0, #0x48]
               	adrp	x0, <page>
               	add	x1, x29, #0x0
               	ldr	x1, [x1]
               	str	x1, [x0, #0x50]
               	adrp	x0, <page>
               	add	x1, x29, #0x0
               	ldr	x1, [x1]
               	str	x1, [x0, #0x58]
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	w1, [x0, #0x30]
               	ldp	x29, x30, [sp], #0x10
               	ret

<outer>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x1, x29, #0x0
               	str	x1, [x0, #0x38]
               	bl	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x2                // =2
               	str	w1, [x0, #0x30]
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	adrp	x1, <page>
               	ldr	x0, [x1, #0x40]
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x50]
               	cbnz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x1, #0x40]
               	adrp	x3, <page>
               	ldr	x3, [x3, <lo12>]
               	cmp	x2, x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x0, #0x50]
               	adrp	x3, <page>
               	ldr	x3, [x3, <lo12>]
               	cmp	x2, x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x0, #0x50]
               	adrp	x3, <page>
               	ldr	x3, [x3, <lo12>]
               	cmp	x2, x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x1, #0x40]
               	ldr	x0, [x0, #0x50]
               	cmp	x1, x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
