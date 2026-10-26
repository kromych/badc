
sys_queue_and_timeval_macros.aarch64:	file format elf64-littleaarch64

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

<lists>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	sub	x7, x29, #0xd8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x7, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x7, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x7, #0x30]
               	ldp	x16, x17, [x0, #0x40]
               	stp	x16, x17, [x7, #0x40]
               	ldp	x16, x17, [x0, #0x50]
               	stp	x16, x17, [x7, #0x50]
               	ldp	x16, x17, [x0, #0x60]
               	stp	x16, x17, [x7, #0x60]
               	ldp	x16, x17, [x0, #0x70]
               	stp	x16, x17, [x7, #0x70]
               	ldp	x16, x17, [x0, #0x80]
               	stp	x16, x17, [x7, #0x80]
               	ldp	x16, x17, [x0, #0x90]
               	stp	x16, x17, [x7, #0x90]
               	ldp	x16, x17, [x0, #0xa0]
               	stp	x16, x17, [x7, #0xa0]
               	ldp	x16, x17, [x0, #0xb0]
               	stp	x16, x17, [x7, #0xb0]
               	ldp	x16, x17, [x0, #0xc0]
               	stp	x16, x17, [x7, #0xc0]
               	ldr	x16, [x0, #0xd0]
               	str	x16, [x7, #0xd0]
               	mov	x1, #0x0                // =0
               	stur	x1, [x29, #-0x100]
               	sub	x0, x29, #0xf8
               	stur	x1, [x29, #-0xf8]
               	stur	x0, [x29, #-0xf0]
               	sub	x0, x29, #0xe8
               	stur	x0, [x29, #-0xe8]
               	stur	x0, [x29, #-0xe0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	cbnz	x2, <addr>
               	ldur	x2, [x29, #-0xe8]
               	cmp	x2, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x48               // =72
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, x1
               	mul	x5, x0, x3
               	add	x2, x7, x5
               	str	x1, [x2, #0x8]
               	ldur	x1, [x29, #-0x100]
               	str	x1, [x2, #0x10]
               	cbz	x1, <addr>
               	ldur	x1, [x29, #-0x100]
               	add	x6, x2, #0x10
               	str	x6, [x1, #0x18]
               	stur	x2, [x29, #-0x100]
               	sub	x1, x29, #0x100
               	str	x1, [x2, #0x18]
               	sub	x1, x29, #0xd8
               	add	x5, x1, x5
               	str	xzr, [x5, #0x20]
               	ldr	x8, [x4, #0x8]
               	str	x5, [x8]
               	mul	x5, x0, x3
               	add	x1, x1, x5
               	add	x8, x1, #0x20
               	str	x8, [x4, #0x8]
               	str	xzr, [x1, #0x28]
               	ldur	x6, [x29, #-0xf0]
               	str	x6, [x1, #0x30]
               	ldur	x6, [x29, #-0xf0]
               	sub	x1, x29, #0xd8
               	add	x1, x1, x5
               	str	x1, [x6]
               	add	x5, x1, #0x28
               	stur	x5, [x29, #-0xf0]
               	sub	x5, x29, #0xe8
               	str	x5, [x1, #0x38]
               	ldur	x6, [x29, #-0xe0]
               	str	x6, [x1, #0x40]
               	ldur	x1, [x29, #-0xe8]
               	cmp	x1, x5
               	b.ne	<addr>
               	sub	x1, x29, #0xd8
               	mul	x5, x0, x3
               	add	x1, x1, x5
               	stur	x1, [x29, #-0xe8]
               	b	<addr>
               	ldur	x1, [x29, #-0xe0]
               	sub	x5, x29, #0xd8
               	mul	x6, x0, x3
               	add	x5, x5, x6
               	str	x5, [x1, #0x38]
               	sub	x1, x29, #0xd8
               	mul	x5, x0, x3
               	add	x1, x1, x5
               	stur	x1, [x29, #-0xe0]
               	add	x0, x0, #0x1
               	mov	x1, x2
               	cmp	w0, #0x3
               	b.lt	<addr>
               	mov	x2, #0x0                // =0
               	mov	x3, #0xa                // =10
               	mov	x0, x1
               	cbz	x0, <addr>
               	mul	x2, x2, x3
               	ldrsw	x4, [x0]
               	add	x2, x2, x4
               	ldr	x0, [x0, #0x8]
               	cbnz	x0, <addr>
               	cmp	x2, #0x141
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	ldur	x0, [x29, #-0x100]
               	mov	x3, #0xa                // =10
               	cbz	x0, <addr>
               	mul	x2, x2, x3
               	ldrsw	x4, [x0]
               	add	x2, x2, x4
               	ldr	x0, [x0, #0x10]
               	cbnz	x0, <addr>
               	cmp	x2, #0x141
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x3, #0xa                // =10
               	cbz	x0, <addr>
               	mul	x2, x2, x3
               	ldrsw	x4, [x0]
               	add	x2, x2, x4
               	ldr	x0, [x0, #0x20]
               	cbnz	x0, <addr>
               	cmp	x2, #0x7b
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	ldur	x0, [x29, #-0xf0]
               	ldr	x0, [x0, #0x8]
               	ldr	x0, [x0]
               	mov	x3, #0xa                // =10
               	cbz	x0, <addr>
               	mul	x2, x2, x3
               	ldrsw	x4, [x0]
               	add	x2, x2, x4
               	ldr	x0, [x0, #0x30]
               	ldr	x0, [x0, #0x8]
               	ldr	x0, [x0]
               	cbnz	x0, <addr>
               	cmp	x2, #0x141
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xf0]
               	ldr	x0, [x0, #0x8]
               	ldr	x2, [x0]
               	sub	x0, x29, #0xd8
               	add	x3, x0, #0x90
               	cmp	x2, x3
               	b.ne	<addr>
               	ldur	x2, [x29, #-0x60]
               	ldr	x2, [x2, #0x8]
               	ldr	x2, [x2]
               	cmp	x2, x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	sub	x3, x29, #0xe8
               	ldur	x0, [x29, #-0xe8]
               	mov	x4, #0xa                // =10
               	cmp	x0, x3
               	b.eq	<addr>
               	mul	x2, x2, x4
               	ldrsw	x5, [x0]
               	add	x2, x2, x5
               	ldr	x0, [x0, #0x38]
               	cmp	x0, x3
               	b.ne	<addr>
               	cmp	x2, #0x7b
               	b.ne	<addr>
               	ldur	x2, [x29, #-0xe0]
               	sub	x0, x29, #0xd8
               	add	x3, x0, #0x90
               	cmp	x2, x3
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x2, x0, #0x48
               	cmp	x1, x2
               	b.ne	<addr>
               	ldr	x1, [x1, #0x8]
               	sub	x2, x29, #0xd8
               	ldur	x0, [x29, #-0x80]
               	cbz	x0, <addr>
               	ldur	x0, [x29, #-0x80]
               	ldur	x3, [x29, #-0x78]
               	str	x3, [x0, #0x18]
               	ldur	x0, [x29, #-0x78]
               	ldur	x3, [x29, #-0x80]
               	str	x3, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x3, [x0]
               	add	x2, x2, #0x48
               	cmp	x3, x2
               	b.ne	<addr>
               	ldr	x2, [x0]
               	ldr	x2, [x2, #0x20]
               	str	x2, [x0]
               	cbnz	x2, <addr>
               	str	x0, [x0, #0x8]
               	ldur	x0, [x29, #-0x68]
               	cbz	x0, <addr>
               	ldur	x0, [x29, #-0x68]
               	ldur	x2, [x29, #-0x60]
               	str	x2, [x0, #0x30]
               	ldur	x0, [x29, #-0x60]
               	ldur	x2, [x29, #-0x68]
               	str	x2, [x0]
               	ldur	x2, [x29, #-0x58]
               	sub	x0, x29, #0xe8
               	cmp	x2, x0
               	b.ne	<addr>
               	ldur	x2, [x29, #-0x50]
               	stur	x2, [x29, #-0xe0]
               	ldur	x2, [x29, #-0x50]
               	cmp	x2, x0
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x58]
               	stur	x0, [x29, #-0xe8]
               	mov	x0, #0x0                // =0
               	mov	x2, #0xa                // =10
               	cbz	x1, <addr>
               	mul	x0, x0, x2
               	ldrsw	x3, [x1]
               	add	x0, x0, x3
               	ldr	x1, [x1, #0x8]
               	cbnz	x1, <addr>
               	ldur	x1, [x29, #-0x100]
               	mov	x2, #0xa                // =10
               	cbz	x1, <addr>
               	mul	x0, x0, x2
               	ldrsw	x3, [x1]
               	add	x0, x0, x3
               	ldr	x1, [x1, #0x10]
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x2, #0xa                // =10
               	cbz	x1, <addr>
               	mul	x0, x0, x2
               	ldrsw	x3, [x1]
               	add	x0, x0, x3
               	ldr	x1, [x1, #0x20]
               	cbnz	x1, <addr>
               	ldur	x1, [x29, #-0xf8]
               	mov	x2, #0xa                // =10
               	cbz	x1, <addr>
               	mul	x0, x0, x2
               	ldrsw	x3, [x1]
               	add	x0, x0, x3
               	ldr	x1, [x1, #0x28]
               	cbnz	x1, <addr>
               	sub	x2, x29, #0xe8
               	ldur	x1, [x29, #-0xe8]
               	mov	x3, #0xa                // =10
               	cmp	x1, x2
               	b.eq	<addr>
               	mul	x0, x0, x3
               	ldrsw	x4, [x1]
               	add	x0, x0, x4
               	ldr	x1, [x1, #0x38]
               	cmp	x1, x2
               	b.ne	<addr>
               	mov	x17, #0x45b1            // =17841
               	movk	x17, #0xbaa1, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xd8
               	ldur	x1, [x29, #-0x18]
               	stur	x1, [x29, #-0x60]
               	add	x2, x0, #0x90
               	stur	x2, [x29, #-0x68]
               	add	x2, x0, #0x48
               	str	x2, [x1]
               	add	x1, x0, #0x70
               	stur	x1, [x29, #-0x18]
               	ldur	x1, [x29, #-0xc8]
               	stur	x1, [x29, #-0x80]
               	cbz	x1, <addr>
               	ldur	x1, [x29, #-0xc8]
               	add	x3, x0, #0x58
               	str	x3, [x1, #0x18]
               	stur	x2, [x29, #-0xc8]
               	add	x0, x0, #0x10
               	stur	x0, [x29, #-0x78]
               	mov	x0, #0x0                // =0
               	ldur	x1, [x29, #-0xf8]
               	mov	x2, #0xa                // =10
               	cbz	x1, <addr>
               	mul	x0, x0, x2
               	ldrsw	x3, [x1]
               	add	x0, x0, x3
               	ldr	x1, [x1, #0x28]
               	cbnz	x1, <addr>
               	ldur	x1, [x29, #-0x100]
               	mov	x2, #0xa                // =10
               	cbz	x1, <addr>
               	mul	x0, x0, x2
               	ldrsw	x3, [x1]
               	add	x0, x0, x3
               	ldr	x1, [x1, #0x10]
               	cbnz	x1, <addr>
               	mov	x17, #0xe1b0            // =57776
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x1, [x1, #0x20]
               	str	x1, [x0]
               	cbnz	x1, <addr>
               	str	x0, [x0, #0x8]
               	ldr	x0, [x0]
               	sub	x1, x29, #0xd8
               	add	x1, x1, #0x90
               	cmp	x0, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x28]
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x50]
               	ldur	x2, [x29, #-0x58]
               	str	x2, [x0, #0x38]
               	b	<addr>
               	ldur	x2, [x29, #-0x58]
               	ldur	x3, [x29, #-0x50]
               	str	x3, [x2, #0x40]
               	b	<addr>
               	ldur	x0, [x29, #-0x60]
               	stur	x0, [x29, #-0xf0]
               	b	<addr>
               	ldr	x0, [x0]
               	ldr	x3, [x0, #0x20]
               	cmp	x3, x2
               	b.eq	<addr>
               	ldr	x0, [x0, #0x20]
               	ldr	x3, [x0, #0x20]
               	cmp	x3, x2
               	b.ne	<addr>
               	ldr	x2, [x0, #0x20]
               	ldr	x2, [x2, #0x20]
               	str	x2, [x0, #0x20]
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x0, x0, #0x20
               	str	x0, [x2, #0x8]
               	b	<addr>
               	mov	x0, x1
               	ldr	x3, [x0, #0x8]
               	cmp	x3, x2
               	b.eq	<addr>
               	ldr	x0, [x0, #0x8]
               	ldr	x3, [x0, #0x8]
               	cmp	x3, x2
               	b.ne	<addr>
               	ldr	x2, [x0, #0x8]
               	ldr	x2, [x2, #0x8]
               	str	x2, [x0, #0x8]
               	b	<addr>

<platform_lists>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x2, x29, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x3, x29, #0x10
               	stp	xzr, xzr, [x3]
               	mov	x1, #0x0                // =0
               	stur	x1, [x29, #-0x10]
               	stur	x3, [x29, #-0x8]
               	stur	x1, [x29, #-0x28]
               	str	x2, [x3]
               	add	x2, x2, #0x8
               	stur	x2, [x29, #-0x8]
               	ldur	x2, [x29, #-0x10]
               	stur	x2, [x29, #-0x18]
               	cbnz	x2, <addr>
               	add	x2, x0, #0x8
               	stur	x2, [x29, #-0x8]
               	stur	x0, [x29, #-0x10]
               	mov	x2, #0xa                // =10
               	cbz	x0, <addr>
               	mul	x1, x1, x2
               	ldrsw	x3, [x0]
               	add	x1, x1, x3
               	ldr	x0, [x0, #0x8]
               	cbnz	x0, <addr>
               	sub	x3, x29, #0x10
               	ldur	x0, [x29, #-0x10]
               	sub	x2, x29, #0x30
               	cmp	x0, x2
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldr	x0, [x0, #0x8]
               	stur	x0, [x29, #-0x10]
               	cbnz	x0, <addr>
               	stur	x3, [x29, #-0x8]
               	cmp	w1, #0x15
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	sub	x1, x29, #0x20
               	cmp	x0, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x18]
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xe                // =14
               	b	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldr	x3, [x0, #0x8]
               	cmp	x3, x2
               	b.eq	<addr>
               	ldr	x0, [x0, #0x8]
               	ldr	x3, [x0, #0x8]
               	cmp	x3, x2
               	b.ne	<addr>
               	ldr	x2, [x0, #0x8]
               	ldr	x2, [x2, #0x8]
               	str	x2, [x0, #0x8]
               	cbnz	x2, <addr>
               	add	x0, x0, #0x8
               	stur	x0, [x29, #-0x8]
               	b	<addr>

<timevals>:
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cbnz	w0, <addr>
               	bl	<addr>
               	cbz	w0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	b	<addr>
