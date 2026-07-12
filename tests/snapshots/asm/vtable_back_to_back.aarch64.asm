
vtable_back_to_back.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2e0              // =736
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
               	str	x19, [sp, #-0x90]!
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
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
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x4
               	blr	x9
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	ldr	x0, [x0, #0x8]
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x40
               	mov	x3, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	mov	x2, x3
               	blr	x9
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x40]
               	bl	<addr>
               	sxtw	x0, w0
               	ldursw	x0, [x29, #-0x40]
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
