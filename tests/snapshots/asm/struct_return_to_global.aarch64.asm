
struct_return_to_global.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	mov	x0, #0x0                // =0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x2, #0x6                // =6
               	sub	x1, x29, #0x10
               	str	x2, [x1]
               	mov	x4, #0x1                // =1
               	str	x4, [x1, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x6]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x6, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x6
               	ldr	x2, [x6]
               	ldr	x3, [x6, #0x8]
               	add	x2, x2, x3
               	add	x7, x2, #0x0
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	lsl	x5, x2, #4
               	add	x5, x3, x5
               	mov	x17, #0xa               // =10
               	mul	x3, x2, x17
               	sxtw	x3, w3
               	str	x3, [x1]
               	str	x4, [x1, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x5]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x5
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	add	x1, x7, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x2, x0
               	add	x1, x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x20
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x2, x0
               	add	x1, x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x30
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x2, x0
               	add	x2, x1, x0
               	sub	x0, x29, #0x20
               	mov	x1, #0x3                // =3
               	str	x1, [x0]
               	mov	x1, #0x4                // =4
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x6]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x6, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x6
               	ldr	x0, [x6]
               	ldr	x1, [x6, #0x8]
               	add	x0, x0, x1
               	add	x0, x2, x0
               	cmp	x0, #0x4e
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
