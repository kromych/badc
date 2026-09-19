
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x1                // =1
               	str	x0, [x1]
               	ldr	x3, [x1]
               	mov	x2, #0x2                // =2
               	str	x2, [x1]
               	ldr	x4, [x1]
               	add	x4, x3, x4
               	mov	x3, #0x3                // =3
               	str	x3, [x1]
               	ldr	x5, [x1]
               	add	x4, x4, x5
               	cmp	x4, #0x6
               	b.eq	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	str	x0, [x1]
               	ldr	x0, [x1]
               	mov	x4, #0x14               // =20
               	str	x4, [x1]
               	ldr	x4, [x1]
               	add	x0, x0, x4
               	mov	x4, #0x1e               // =30
               	str	x4, [x1]
               	ldr	x4, [x1]
               	add	x0, x0, x4
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	mov	x0, x2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	str	x0, [x1]
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldr	x1, [x0]
               	ldr	x1, [x1]
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	add	x0, x1, x0
               	cmp	x0, #0xe
               	b.eq	<addr>
               	mov	x0, x3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
