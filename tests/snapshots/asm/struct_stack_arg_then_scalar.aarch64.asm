
struct_stack_arg_then_scalar.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x48
               	sub	x1, x29, #0x30
               	sub	x2, x29, #0x40
               	sub	x3, x29, #0x20
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x3]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x20
               	sub	x4, x29, #0x10
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x5]
               	str	x10, [x4]
               	ldr	x10, [x5, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x10
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	ldr	x1, [x1, #0x8]
               	mov	x17, #0x2710            // =10000
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	mov	x17, #0x1b58            // =7000
               	add	x0, x0, x17
               	ldr	x1, [x2, #0x8]
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldr	x1, [x3, #0x8]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldr	x1, [x4, #0x8]
               	add	x0, x0, x1
               	add	x0, x0, #0x5
               	mov	x17, #0x7a9e            // =31390
               	movk	x17, #0x12, lsl #16
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
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
