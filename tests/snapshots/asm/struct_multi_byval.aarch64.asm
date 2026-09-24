
struct_multi_byval.aarch64:	file format elf64-littleaarch64

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

<take_many>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	stur	x0, [x29, #-0x8]
               	stur	x2, [x29, #-0x18]
               	stur	x3, [x29, #-0x10]
               	stur	x4, [x29, #-0x20]
               	stur	x5, [x29, #-0x30]
               	stur	x6, [x29, #-0x28]
               	sub	x0, x29, #0x48
               	ldr	x1, [x29, #0x10]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x1, x29, #0x8
               	ldrsw	x3, [x1]
               	ldrsw	x1, [x1, #0x4]
               	add	x1, x3, x1
               	add	x3, x1, #0x3e8
               	sub	x1, x29, #0x18
               	ldrsw	x4, [x1]
               	add	x3, x3, x4
               	ldrsw	x4, [x1, #0x4]
               	add	x3, x3, x4
               	ldrsw	x1, [x1, #0x8]
               	add	x1, x3, x1
               	ldursw	x3, [x29, #-0x20]
               	add	x3, x1, x3
               	sub	x1, x29, #0x30
               	ldrsw	x4, [x1]
               	add	x3, x3, x4
               	ldrsw	x4, [x1, #0x4]
               	add	x3, x3, x4
               	ldrsw	x4, [x1, #0x8]
               	add	x3, x3, x4
               	ldrsw	x1, [x1, #0xc]
               	add	x1, x3, x1
               	add	x1, x1, #0x7d0
               	ldrsw	x3, [x0]
               	add	x1, x1, x3
               	ldrsw	x3, [x0, #0x4]
               	add	x1, x1, x3
               	ldrsw	x3, [x0, #0x8]
               	add	x1, x1, x3
               	ldrsw	x3, [x0, #0xc]
               	add	x1, x1, x3
               	ldrsw	x3, [x0, #0x10]
               	add	x1, x1, x3
               	ldrsw	x0, [x0, #0x14]
               	add	x0, x1, x0
               	ldrsw	x1, [x29, #0x18]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	str	x0, [x2]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x2, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x2]
               	ldr	w16, [x1, #0x8]
               	str	w16, [x2, #0x8]
               	sub	x4, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w16, [x1]
               	str	w16, [x4]
               	sub	x5, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x5]
               	sub	x3, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x3, #0x10]
               	mov	x1, #0x3e8              // =1000
               	mov	x7, #0x7d0              // =2000
               	mov	x6, #0xbb8              // =3000
               	sub	sp, sp, #0x10
               	str	x3, [sp]
               	str	x6, [sp, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	ldr	x4, [x4]
               	ldr	x6, [x5, #0x8]
               	ldr	x5, [x5]
               	bl	<addr>
               	add	sp, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0x1a12            // =6674
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
