
dirent_stream.aarch64:	file format elf64-littleaarch64

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

<in_dir>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0x258              // =600
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x16, x4
               	mov	x4, x0
               	mov	x0, x16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x29, x30, [sp], #0x10
               	ret

<scan>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x24, x0
               	mov	x20, x1
               	mov	x21, #0x0               // =0
               	str	w21, [x20]
               	b	<addr>
               	add	x21, x21, #0x1
               	add	x23, x22, #0x13
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x23
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldrsw	x0, [x20]
               	orr	x0, x0, #0x1
               	str	w0, [x20]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x23
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldrsw	x0, [x20]
               	orr	x0, x0, #0x2
               	str	w0, [x20]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x23
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldrsw	x0, [x20]
               	orr	x0, x0, #0x4
               	str	w0, [x20]
               	add	x0, x22, #0x13
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldrsw	x0, [x20]
               	orr	x0, x0, #0x8
               	str	w0, [x20]
               	mov	x0, x24
               	bl	<addr>
               	mov	x22, x0
               	cbnz	x22, <addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x140]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x130]
               	add	x29, sp, #0x130
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	cbnz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	cbnz	x20, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x21, x0
               	bl	<addr>
               	mov	x5, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, x20
               	mov	x4, x21
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1c0              // =448
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
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
               	bl	<addr>
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
               	bl	<addr>
               	bl	<addr>
               	cbnz	x0, <addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x14
               	b.eq	<addr>
               	mov	x20, #0xc               // =12
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	sub	x1, x29, #0x110
               	mov	x0, x21
               	bl	<addr>
               	cmp	w0, #0x4
               	b.ne	<addr>
               	ldrsw	x0, [sp, #0x20]
               	cmp	w0, #0xf
               	b.eq	<addr>
               	mov	x20, #0x5               // =5
               	mov	x0, x21
               	bl	<addr>
               	cbnz	w20, <addr>
               	sub	x1, x29, #0x110
               	mov	x0, x21
               	bl	<addr>
               	cmp	w0, #0x4
               	b.ne	<addr>
               	ldrsw	x0, [sp, #0x20]
               	cmp	w0, #0xf
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
               	sub	x0, x29, #0x108
               	add	x1, x22, #0x13
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
