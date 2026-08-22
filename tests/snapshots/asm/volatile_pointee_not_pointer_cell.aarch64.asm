
volatile_pointee_not_pointer_cell.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	ldr	x4, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x2                // =2
               	str	x3, [x2]
               	ldr	x5, [x0]
               	add	x5, x4, x5
               	mov	x4, #0x3                // =3
               	str	x4, [x2]
               	ldr	x2, [x0]
               	add	x2, x5, x2
               	cmp	x2, #0x6
               	b.eq	<addr>
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xa                // =10
               	str	x1, [x0]
               	ldr	x1, [x0]
               	mov	x2, #0x14               // =20
               	str	x2, [x0]
               	ldr	x2, [x0]
               	add	x1, x1, x2
               	mov	x2, #0x1e               // =30
               	str	x2, [x0]
               	ldr	x2, [x0]
               	add	x1, x1, x2
               	cmp	x1, #0x3c
               	b.eq	<addr>
               	mov	x0, x3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x7                // =7
               	str	x1, [x0]
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldr	x1, [x0]
               	ldr	x1, [x1]
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	add	x0, x1, x0
               	cmp	x0, #0xe
               	b.eq	<addr>
               	mov	x0, x4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
