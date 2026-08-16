
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

<walk_reassigned>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	stur	x0, [x29, #0x10]
               	ldur	x0, [x29, #0x10]
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	stur	x1, [x29, #0x10]
               	ldur	x1, [x29, #0x10]
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	stur	x1, [x29, #0x10]
               	ldur	x1, [x29, #0x10]
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<read_thrice>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	stur	x0, [x29, #0x10]
               	ldur	x0, [x29, #0x10]
               	ldr	x0, [x0]
               	ldur	x1, [x29, #0x10]
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	ldur	x1, [x29, #0x10]
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<both_qualified>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	stur	x0, [x29, #0x10]
               	ldur	x0, [x29, #0x10]
               	ldr	x0, [x0]
               	ldur	x1, [x29, #0x10]
               	mov	x2, #0x5                // =5
               	str	x2, [x1]
               	ldur	x1, [x29, #0x10]
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3                // =3
               	str	x1, [x0]
               	bl	<addr>
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
