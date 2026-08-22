
local_multidim_struct_array_designator.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x18]
               	cmp	w1, #0x3
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x1c]
               	cmp	w1, #0x4
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x9
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x4]
               	cmp	w1, #0x1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1, #0x8]
               	cmp	w2, #0x0
               	cset	x1, ne
               	cbnz	x2, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x14]
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x40
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [x2, #0x20]
               	str	x10, [x1, #0x20]
               	ldr	x10, [x2, #0x28]
               	str	x10, [x1, #0x28]
               	ldr	x10, [x2, #0x30]
               	str	x10, [x1, #0x30]
               	ldr	x10, [x2, #0x38]
               	str	x10, [x1, #0x38]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	sub	x2, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x2, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x2, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	mov	x1, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x2, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x2, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	mov	x1, x0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
