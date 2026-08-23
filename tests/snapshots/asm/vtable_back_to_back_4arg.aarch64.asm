
vtable_back_to_back_4arg.aarch64:	file format elf64-littleaarch64

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

<g_init>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0]
               	add	x1, x2, x3
               	str	w1, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	ret

<g_generate>:
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x0, #0x64
               	str	w0, [x1]
               	sxtw	x0, w2
               	ret

<driver>:
               	stp	x20, x21, [sp, #-0x50]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x20, x29, #0x18
               	mov	x0, #0x0                // =0
               	str	x0, [x20]
               	str	x0, [x20, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x21, #0x1               // =1
               	mov	x3, #0x64               // =100
               	mov	x9, x0
               	mov	x0, x20
               	mov	x2, x21
               	blr	x9
               	ldr	x0, [x20]
               	ldr	x0, [x0, #0x8]
               	sub	x1, x29, #0x8
               	mov	x9, x0
               	mov	x0, x20
               	mov	x2, x21
               	blr	x9
               	ldursw	x0, [x29, #-0x8]
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x90]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	sub	x20, x29, #0x10
               	mov	x0, #0x0                // =0
               	str	x0, [x20]
               	str	x0, [x20, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x21, #0x1               // =1
               	mov	x3, #0x64               // =100
               	mov	x9, x0
               	mov	x0, x20
               	mov	x2, x21
               	blr	x9
               	ldr	x0, [x20]
               	ldr	x0, [x0, #0x8]
               	sub	x1, x29, #0x40
               	mov	x9, x0
               	mov	x0, x20
               	mov	x2, x21
               	blr	x9
               	ldursw	x0, [x29, #-0x40]
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
