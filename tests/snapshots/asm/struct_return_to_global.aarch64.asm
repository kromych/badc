
struct_return_to_global.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x1, x29, #0x10
               	str	x0, [x1]
               	sub	x0, x29, #0x10
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<store_global>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xa0]!
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	mov	x0, #0x0                // =0
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x6                // =6
               	sub	x2, x29, #0x60
               	str	x1, [x2]
               	sub	x1, x29, #0x60
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x8]
               	sub	x1, x29, #0x60
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x20]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x20
               	ldr	x1, [x20]
               	ldr	x2, [x20, #0x8]
               	add	x1, x1, x2
               	add	x5, x1, #0x0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	lsl	x3, x1, #4
               	add	x3, x2, x3
               	mov	x17, #0xa               // =10
               	mul	x2, x1, x17
               	sxtw	x2, w2
               	sub	x4, x29, #0x70
               	str	x2, [x4]
               	sub	x2, x29, #0x70
               	mov	x4, #0x1                // =1
               	str	x4, [x2, #0x8]
               	sub	x2, x29, #0x70
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
               	add	x1, x5, x0
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
               	add	x21, x1, x0
               	sub	x0, x29, #0x48
               	mov	x1, #0x3                // =3
               	str	x1, [x0]
               	sub	x0, x29, #0x48
               	mov	x1, #0x4                // =4
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x48
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	ldr	x0, [x20]
               	ldr	x1, [x20, #0x8]
               	add	x0, x0, x1
               	add	x0, x21, x0
               	cmp	x0, #0x4e
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
