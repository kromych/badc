
posix_module_headers.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x5d0              // =1488
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x400
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x0, #0x41               // =65
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	sxtw	x0, w20
               	cmp	x0, #0x41
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbnz	x1, <addr>
               	sxtw	x0, w20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x61
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x41
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x20, w20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x88
               	mov	x20, #0x2               // =2
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x88
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	mov	x1, #0xf                // =15
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	mov	x20, #0x2               // =2
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x88
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cbnz	x2, <addr>
               	mov	x2, #0x0                // =0
               	cbz	x2, <addr>
               	mov	x0, #0x9                // =9
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	sub	x1, x29, #0xb0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xd0
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0xd0
               	str	x1, [x0]
               	mov	x2, #0x0                // =0
               	cbz	x2, <addr>
               	mov	x2, #0x0                // =0
               	cbz	x2, <addr>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x1, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xf0
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	sub	x0, x29, #0x2f0
               	cmp	x0, #0x0
               	cset	x0, eq
               	mov	x2, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x370
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	sub	x0, x29, #0x390
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0xf0
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	b	<addr>
