
posix_module_headers.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x380
               	stp	x20, x21, [sp]
               	str	x19, [sp, #0x10]
               	mov	x0, #0x41               // =65
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	sxtw	x21, w20
               	cmp	x21, #0x41
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x380
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	cmp	x1, #0x0
               	cset	x0, eq
               	cbz	x1, <addr>
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x380
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x61
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x380
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x41
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x380
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x380
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x358
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, #0x2               // =2
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x380
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xf                // =15
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x380
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x358
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x380
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	mov	x0, x20
               	mov	x0, #0x4                // =4
               	sub	x1, x29, #0x2d8
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x380
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	mov	x0, x20
               	mov	x0, x20
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x380
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
