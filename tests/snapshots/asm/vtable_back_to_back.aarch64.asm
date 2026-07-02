
vtable_back_to_back.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0]
               	add	x1, x2, x3
               	str	w1, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	ret

<my_generate>:
               	sxtw	x2, w2
               	ldrsw	x0, [x0, #0x8]
               	str	w0, [x1]
               	mov	x0, x2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x19, [sp]
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	sub	x1, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x2a               // =42
               	mov	x4, #0x8                // =8
               	str	x4, [sp, #-0x10]!
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	mov	x9, x0
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	ldr	x2, [sp, #0x20]
               	ldr	x3, [sp, #0x30]
               	blr	x9
               	add	sp, sp, #0x40
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	ldr	x0, [x0, #0x8]
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x40
               	mov	x3, #0x1                // =1
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	mov	x9, x0
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	ldr	x2, [sp, #0x20]
               	blr	x9
               	add	sp, sp, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x40]
               	bl	<addr>
               	sxtw	x0, w0
               	ldursw	x0, [x29, #-0x40]
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
