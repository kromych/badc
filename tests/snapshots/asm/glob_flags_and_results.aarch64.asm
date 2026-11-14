
glob_flags_and_results.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x1e0
               	str	x20, [sp]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x1e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x180
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0x80               // =128
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	sub	x0, x29, #0x80
               	mov	x1, #0x80               // =128
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0x241              // =577
               	mov	x2, #0x180              // =384
               	bl	<addr>
               	cmp	w0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x1e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbnz	w0, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	sub	x0, x29, #0x80
               	mov	x1, #0x80               // =128
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0x241              // =577
               	mov	x2, #0x180              // =384
               	bl	<addr>
               	cmp	w0, #0x0
               	b.lt	<addr>
               	bl	<addr>
               	cbnz	w0, <addr>
               	sub	x0, x29, #0x180
               	mov	x1, #0x1c0              // =448
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x100
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0x80               // =128
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x100
               	mov	x1, #0x0                // =0
               	sub	x3, x29, #0x1c8
               	mov	x2, x1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x20, #0x2               // =2
               	sub	x0, x29, #0x100
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0x80               // =128
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x100
               	bl	<addr>
               	sub	x0, x29, #0x100
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0x80               // =128
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x100
               	bl	<addr>
               	sub	x0, x29, #0x180
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x1e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp, #0x18]
               	cmp	x0, #0x2
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	ldr	x0, [sp, #0x20]
               	ldr	x20, [x0]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	sub	x0, x29, #0x80
               	mov	x1, #0x80               // =128
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sub	x1, x29, #0x80
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	mov	x20, #0x0               // =0
               	cbz	x0, <addr>
               	ldr	x0, [sp, #0x20]
               	ldr	x20, [x0, #0x8]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	sub	x0, x29, #0x80
               	mov	x1, #0x80               // =128
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sub	x1, x29, #0x80
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x20, eq
               	sub	x0, x29, #0x1c8
               	bl	<addr>
               	cbnz	w20, <addr>
               	mov	x20, #0x3               // =3
               	b	<addr>
               	sub	x0, x29, #0x100
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0x80               // =128
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x100
               	mov	x1, #0x2                // =2
               	mov	x2, #0x0                // =0
               	sub	x3, x29, #0x1c8
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x20, #0x4               // =4
               	b	<addr>
               	ldr	x0, [sp, #0x18]
               	cmp	x0, #0x1
               	mov	x20, #0x0               // =0
               	b.ne	<addr>
               	ldr	x0, [sp, #0x20]
               	ldr	x20, [x0]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	sub	x0, x29, #0x80
               	mov	x1, #0x80               // =128
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sub	x1, x29, #0x80
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x20, eq
               	sub	x0, x29, #0x1c8
               	bl	<addr>
               	cbnz	w20, <addr>
               	mov	x20, #0x5               // =5
               	b	<addr>
               	sub	x0, x29, #0x100
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0x80               // =128
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x100
               	mov	x1, #0x0                // =0
               	sub	x3, x29, #0x1c8
               	mov	x2, x1
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x20, #0x6               // =6
               	b	<addr>
               	sub	x0, x29, #0x100
               	mov	x1, #0x10               // =16
               	mov	x2, #0x0                // =0
               	sub	x3, x29, #0x1c8
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldr	x0, [sp, #0x18]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldr	x0, [sp, #0x20]
               	ldr	x0, [x0]
               	sub	x1, x29, #0x100
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x20, #0x7               // =7
               	b	<addr>
               	sub	x0, x29, #0x100
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0x80               // =128
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x100
               	mov	x1, #0x20               // =32
               	mov	x2, #0x0                // =0
               	sub	x3, x29, #0x1c8
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x20, #0x8               // =8
               	b	<addr>
               	ldr	x0, [sp, #0x18]
               	cmp	x0, #0x2
               	mov	x20, #0x0               // =0
               	b.ne	<addr>
               	ldr	x0, [sp, #0x20]
               	ldr	x20, [x0, #0x8]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	sub	x0, x29, #0x80
               	mov	x1, #0x80               // =128
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sub	x1, x29, #0x80
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x20, eq
               	sub	x0, x29, #0x1c8
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x9                // =9
               	cmp	x20, #0x0
               	csel	x20, x0, x1, ne
               	b	<addr>
