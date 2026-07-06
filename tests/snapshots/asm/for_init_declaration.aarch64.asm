
for_init_declaration.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x2d               // =45
               	ret

<multi_decl>:
               	mov	x0, #0x32               // =50
               	ret

<shadowing>:
               	mov	x0, #0x2a               // =42
               	ret

<adjacent_fors>:
               	mov	x0, #0x2b               // =43
               	ret

<struct_ptr_init>:
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
               	b	<addr>
               	ldrsw	x2, [x1]
               	add	x3, x3, x2
               	add	x1, x1, #0x4
               	add	x2, x0, #0xc
               	cmp	x1, x2
               	b.lt	<addr>
               	sxtw	x0, w3
               	ret

<main>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
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
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
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
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
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
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
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
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
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
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
