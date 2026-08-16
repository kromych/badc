
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
               	sub	sp, sp, #0x50
               	mov	x0, #0x0                // =0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x6                // =6
               	sub	x2, x29, #0x20
               	str	x1, [x2]
               	sub	x1, x29, #0x20
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x8]
               	sub	x1, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x5]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x5
               	ldr	x1, [x5]
               	ldr	x2, [x5, #0x8]
               	add	x1, x1, x2
               	add	x6, x1, #0x0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	lsl	x3, x1, #4
               	add	x3, x2, x3
               	mov	x17, #0xa               // =10
               	mul	x2, x1, x17
               	sxtw	x2, w2
               	sub	x4, x29, #0x30
               	str	x2, [x4]
               	sub	x2, x29, #0x30
               	mov	x4, #0x1                // =1
               	str	x4, [x2, #0x8]
               	sub	x2, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x3
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	add	x1, x6, x0
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
               	add	x1, x1, x0
               	sub	x0, x29, #0x40
               	mov	x2, #0x3                // =3
               	str	x2, [x0]
               	sub	x0, x29, #0x40
               	mov	x2, #0x4                // =4
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x40
               	sub	x2, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x0, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x5]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x5
               	ldr	x0, [x5]
               	ldr	x2, [x5, #0x8]
               	add	x0, x0, x2
               	add	x0, x1, x0
               	cmp	x0, #0x4e
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
