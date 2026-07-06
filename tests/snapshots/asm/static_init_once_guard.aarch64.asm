
static_init_once_guard.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsb	x1, [x0, #0x10]
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	stur	x1, [x29, #-0x8]
               	b	<addr>
               	adr	x1, <addr>
               	str	x1, [x0]
               	adr	x1, <addr>
               	str	x1, [x0, #0x8]
               	mov	x1, #0x1                // =1
               	strb	w1, [x0, #0x10]
               	stur	x1, [x29, #-0x8]
               	ldursw	x1, [x29, #0x10]
               	cmp	x1, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x0]
               	str	x2, [x1]
               	ldr	x1, [x0, #0x8]
               	str	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	br	x0
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ldr	x0, [x0]
               	br	x0

<flag_table>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	sxtw	x1, w1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsb	x3, [x2, #0x10]
               	cbz	x3, <addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x5, #0x0                // =0
               	b	<addr>
               	cbz	x1, <addr>
               	b	<addr>
               	mov	x5, #0x1                // =1
               	str	w5, [x2]
               	mov	x3, #0x0                // =0
               	str	w3, [x2, #0x4]
               	mov	x4, #0x1                // =1
               	str	w4, [x2, #0x8]
               	strb	w4, [x2, #0x10]
               	b	<addr>
               	mov	x1, #0x7                // =7
               	str	w1, [x2, #0x4]
               	ldrsw	x0, [x2, x0, lsl #2]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, x0
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
