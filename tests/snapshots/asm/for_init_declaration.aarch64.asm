
for_init_declaration.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	sxtw	x2, w1
               	cmp	x2, #0xa
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	b	<addr>
               	sxtw	x0, w0
               	sxtw	x2, w1
               	add	x0, x0, x2
               	b	<addr>
               	sxtw	x0, w0
               	ret

<multi_decl>:
               	mov	x2, #0x0                // =0
               	mov	x1, #0xa                // =10
               	mov	x0, x2
               	sxtw	x3, w2
               	sxtw	x4, w1
               	cmp	x3, x4
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x2, w2
               	add	x2, x2, #0x1
               	sxtw	x1, w1
               	sub	x1, x1, #0x1
               	b	<addr>
               	sxtw	x0, w0
               	sxtw	x3, w2
               	sxtw	x4, w1
               	add	x3, x3, x4
               	sxtw	x3, w3
               	add	x0, x0, x3
               	b	<addr>
               	sxtw	x0, w0
               	ret

<shadowing>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x2a               // =42
               	mov	x2, #0x0                // =0
               	sxtw	x1, w2
               	cmp	x1, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x1, w2
               	add	x2, x1, #0x1
               	b	<addr>
               	b	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<adjacent_fors>:
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	sxtw	x2, w1
               	cmp	x2, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	b	<addr>
               	sxtw	x0, w0
               	sxtw	x2, w1
               	add	x0, x0, x2
               	b	<addr>
               	mov	x2, #0xa                // =10
               	sxtw	x1, w2
               	cmp	x1, #0xd
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x1, w2
               	add	x2, x1, #0x1
               	b	<addr>
               	sxtw	x0, w0
               	sxtw	x1, w2
               	add	x0, x0, x1
               	b	<addr>
               	sxtw	x0, w0
               	ret

<struct_ptr_init>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x3, #0x0                // =0
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	mov	x1, #0x4                // =4
               	mov	x2, #0x2                // =2
               	str	w2, [x0, #0x4]
               	str	w1, [x0, #0x8]
               	mov	x1, x0
               	add	x2, x0, #0xc
               	cmp	x1, x2
               	b.ge	<addr>
               	b	<addr>
               	add	x1, x1, #0x4
               	b	<addr>
               	sxtw	x2, w3
               	ldrsw	x3, [x1]
               	add	x3, x2, x3
               	b	<addr>
               	sxtw	x0, w3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	bl	<addr>
               	cmp	x0, #0x2d
               	b.eq	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x32
               	b.eq	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x2b
               	b.eq	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
