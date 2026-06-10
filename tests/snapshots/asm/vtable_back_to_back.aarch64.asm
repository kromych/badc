
vtable_back_to_back.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0xf0
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x108
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x10e
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x115
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<my_init>:
               	sxtw	x2, w2
               	sxtw	x3, w3
               	adrp	x1, <page>
               	add	x1, x1, #0x120
               	str	x1, [x0]
               	add	x1, x2, x3
               	sxtw	x1, w1
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
               	add	x1, x1, #0x140
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	adrp	x0, <page>
               	add	x0, x0, #0x120
               	ldr	x0, [x0]
               	sub	x1, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x130
               	mov	x3, #0x2a               // =42
               	mov	x4, #0x8                // =8
               	mov	x9, x0
               	str	x4, [sp, #-0x10]!
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
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
               	mov	x9, x0
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	ldr	x2, [sp, #0x20]
               	blr	x9
               	add	sp, sp, #0x30
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	ldursw	x1, [x29, #-0x40]
               	bl	<addr>
               	sxtw	x0, w0
               	ldursw	x0, [x29, #-0x40]
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
