
const_object_address_read.aarch64:	file format elf64-littleaarch64

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

<f>:
               	mov	x0, #0x7                // =7
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cmp	x1, x0
               	b.ne	<addr>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	cmp	x1, x0
               	b.ne	<addr>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	cmp	x1, x0
               	b.ne	<addr>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.ne	<addr>
               	blr	x0
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
