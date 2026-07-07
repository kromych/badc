
struct_stack_arg_then_scalar.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x10
               	ldr	x16, [sp, #0x20]
               	str	x16, [sp]
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x16, x29, #0x10
               	str	x1, [x16]
               	str	x2, [x16, #0x8]
               	sub	x16, x29, #0x20
               	str	x4, [x16]
               	str	x5, [x16, #0x8]
               	sub	x16, x29, #0x30
               	str	x6, [x16]
               	str	x7, [x16, #0x8]
               	sub	x16, x29, #0x40
               	ldr	x17, [x29, #0x80]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x88]
               	str	x17, [x16, #0x8]
               	mov	x2, x3
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	mul	x0, x0, x17
               	sxtw	x1, w0
               	sub	x0, x29, #0x10
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x2710            // =10000
               	mul	x0, x0, x17
               	add	x1, x1, x0
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x2, x17
               	sxtw	x0, w0
               	add	x1, x1, x0
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x1, x1, x0
               	sub	x0, x29, #0x30
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	add	x1, x1, x0
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	ldursw	x1, [x29, #0x70]
               	add	x0, x0, x1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x70
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<dp>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x16, x29, #0x10
               	str	x1, [x16]
               	str	x2, [x16, #0x8]
               	sub	x16, x29, #0x20
               	str	x4, [x16]
               	str	x5, [x16, #0x8]
               	mov	x2, x3
               	mov	x4, x6
               	sxtw	x2, w2
               	sxtw	x4, w4
               	sub	x1, x29, #0x10
               	sub	x3, x29, #0x20
               	sub	x5, x29, #0x58
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x6]
               	str	x10, [x5]
               	ldr	x10, [x6, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x5, x29, #0x58
               	sub	x6, x29, #0x70
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x7]
               	str	x10, [x6]
               	ldr	x10, [x7, #0x8]
               	str	x10, [x6, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x6, x29, #0x70
               	sub	sp, sp, #0x20
               	str	x4, [sp, #0x10]
               	mov	x16, x6
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	mov	x4, x3
               	mov	x6, x5
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	ldr	x5, [x4, #0x8]
               	ldr	x4, [x4]
               	ldr	x7, [x6, #0x8]
               	ldr	x6, [x6]
               	bl	<addr>
               	add	sp, sp, #0x20
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x50
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x18
               	mov	x2, #0x7                // =7
               	sub	x3, x29, #0x28
               	mov	x4, #0x5                // =5
               	mov	x6, x4
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	ldr	x5, [x4, #0x8]
               	ldr	x4, [x4]
               	bl	<addr>
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
