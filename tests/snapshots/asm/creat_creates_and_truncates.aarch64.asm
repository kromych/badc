
creat_creates_and_truncates.aarch64:	file format elf64-littleaarch64

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
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	w16, [x1, #0x8]
               	str	w16, [x0, #0x8]
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0x10
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x180              // =384
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x3, x0
               	cmp	x3, #0x0
               	b.ge	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	str	x3, [sp, #0x10]
               	mov	x0, x3
               	bl	<addr>
               	ldr	x3, [sp, #0x10]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	mov	x0, x3
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x3, x0
               	cbnz	x3, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x2                // =2
               	str	x3, [sp, #0x8]
               	mov	x0, x3
               	bl	<addr>
               	ldr	x3, [sp, #0x8]
               	str	x3, [sp, #0x8]
               	mov	x0, x3
               	bl	<addr>
               	str	x0, [sp, #0x18]
               	ldr	x3, [sp, #0x8]
               	mov	x0, x3
               	bl	<addr>
               	ldr	x16, [sp, #0x18]
               	cmp	x16, #0x3
               	b.ne	<addr>
               	sub	x0, x29, #0x10
               	mov	x1, #0x180              // =384
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.lt	<addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x3, x0
               	cbnz	x3, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x2                // =2
               	str	x3, [sp]
               	mov	x0, x3
               	bl	<addr>
               	ldr	x3, [sp]
               	str	x3, [sp]
               	mov	x0, x3
               	bl	<addr>
               	str	x0, [sp, #0x18]
               	ldr	x3, [sp]
               	mov	x0, x3
               	bl	<addr>
               	ldr	x16, [sp, #0x18]
               	cbnz	x16, <addr>
               	sub	x0, x29, #0x10
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, #0x7                // =7
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x0
               	csel	x0, x1, x2, ne
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
