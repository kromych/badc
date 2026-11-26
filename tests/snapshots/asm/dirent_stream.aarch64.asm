
dirent_stream.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x20, x21, [sp, #-0x160]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x150]
               	add	x29, sp, #0x150
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x21, x0
               	cbnz	x21, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x21, x0
               	cbnz	x21, <addr>
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x11
               	b.ne	<addr>
               	cmp	w20, #0x3e8
               	b.eq	<addr>
               	add	x20, x20, #0x1
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x5, x0
               	mov	x3, x21
               	mov	x6, x20
               	mov	x4, x22
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1c0              // =448
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x258              // =600
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x150]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	ret
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x258              // =600
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x150]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	ret
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x21, x0
               	cbnz	x21, <addr>
               	mov	x20, #0x4               // =4
               	bl	<addr>
               	str	wzr, [x0]
               	cbnz	w20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x258              // =600
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x20, #0xb               // =11
               	bl	<addr>
               	str	wzr, [x0]
               	cbnz	w20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x258              // =600
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x14
               	b.eq	<addr>
               	mov	x20, #0xc               // =12
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x258              // =600
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x258              // =600
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x150]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	ret
               	mov	x20, #0x0               // =0
               	mov	x23, x20
               	b	<addr>
               	add	x23, x23, #0x1
               	add	x24, x22, #0x13
               	mov	x0, x24
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	orr	x1, x20, #0x1
               	cmp	x0, #0x0
               	csel	x20, x20, x1, ne
               	mov	x0, x24
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	orr	x1, x20, #0x2
               	cmp	x0, #0x0
               	csel	x20, x20, x1, ne
               	add	x22, x22, #0x13
               	mov	x0, x22
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	orr	x1, x20, #0x4
               	cmp	x0, #0x0
               	csel	x20, x20, x1, ne
               	mov	x0, x22
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	orr	x1, x20, #0x8
               	cmp	x0, #0x0
               	csel	x20, x20, x1, ne
               	mov	x0, x21
               	bl	<addr>
               	mov	x22, x0
               	cbnz	x22, <addr>
               	cmp	w23, #0x4
               	b.ne	<addr>
               	cmp	w20, #0xf
               	b.eq	<addr>
               	mov	x20, #0x5               // =5
               	mov	x0, x21
               	bl	<addr>
               	cbnz	w20, <addr>
               	mov	x22, #0x0               // =0
               	mov	x24, x22
               	b	<addr>
               	add	x24, x24, #0x1
               	add	x1, x23, #0x13
               	str	x1, [sp, #0x38]
               	mov	x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x1, [sp, #0x38]
               	orr	x2, x22, #0x1
               	cmp	x0, #0x0
               	csel	x22, x22, x2, ne
               	mov	x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	orr	x1, x22, #0x2
               	cmp	x0, #0x0
               	csel	x22, x22, x1, ne
               	add	x23, x23, #0x13
               	mov	x0, x23
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	orr	x1, x22, #0x4
               	cmp	x0, #0x0
               	csel	x22, x22, x1, ne
               	mov	x0, x23
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	orr	x1, x22, #0x8
               	cmp	x0, #0x0
               	csel	x22, x22, x1, ne
               	mov	x0, x21
               	bl	<addr>
               	mov	x23, x0
               	cbnz	x23, <addr>
               	cmp	w24, #0x4
               	b.ne	<addr>
               	cmp	w22, #0xf
               	b.eq	<addr>
               	mov	x20, #0x6               // =6
               	mov	x0, x21
               	bl	<addr>
               	cbnz	w20, <addr>
               	mov	x0, x21
               	bl	<addr>
               	mov	x22, x0
               	cbnz	x22, <addr>
               	mov	x20, #0x7               // =7
               	mov	x0, x21
               	bl	<addr>
               	mov	x23, x0
               	cbnz	w20, <addr>
               	mov	x0, x21
               	bl	<addr>
               	mov	x22, x0
               	cbnz	x22, <addr>
               	mov	x20, #0x8               // =8
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	cbnz	w20, <addr>
               	mov	x20, #0xa               // =10
               	b	<addr>
               	cbnz	w20, <addr>
               	add	x1, x22, #0x13
               	sub	x0, x29, #0x108
               	bl	<addr>
               	mov	x0, x21
               	mov	x1, x23
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	cbz	x0, <addr>
               	add	x0, x0, #0x13
               	sub	x1, x29, #0x108
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x20, #0x9               // =9
               	b	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x150]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	ret
