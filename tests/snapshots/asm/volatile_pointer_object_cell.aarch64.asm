
volatile_pointer_object_cell.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	stur	x1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	stur	x1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	ldr	x0, [x0]
               	ldur	x1, [x29, #-0x10]
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x10]
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3                // =3
               	str	x1, [x0]
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	ldr	x0, [x0]
               	ldur	x2, [x29, #-0x8]
               	mov	x3, #0x5                // =5
               	str	x3, [x2]
               	ldur	x2, [x29, #-0x8]
               	ldr	x2, [x2]
               	add	x0, x0, x2
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
