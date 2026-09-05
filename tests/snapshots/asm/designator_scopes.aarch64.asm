
designator_scopes.aarch64:	file format elf64-littleaarch64

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

<scalar_forms>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	ldrsw	x3, [x0, #0x8]
               	add	x1, x1, x3
               	ldrsw	x3, [x0, #0xc]
               	add	x1, x1, x3
               	ldrsw	x3, [x0, #0x10]
               	add	x1, x1, x3
               	cmp	w1, #0x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	ldrsw	x4, [x1, #0x8]
               	add	x3, x3, x4
               	ldrsw	x4, [x1, #0xc]
               	add	x3, x3, x4
               	ldrsw	x1, [x1, #0x10]
               	add	x1, x3, x1
               	cmp	w1, #0x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x10]
               	cbnz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x3, [x3, #0x10]
               	cmp	w3, #0x0
               	cset	x3, ne
               	cbnz	x3, <addr>
               	mov	x2, x1
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x9
               	b.ne	<addr>
               	mov	x0, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x9
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<nested_struct_array>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x28]
               	ldrsw	x3, [x0, #0x2c]
               	add	x1, x1, x3
               	ldrsw	x3, [x0, #0x8]
               	add	x1, x1, x3
               	ldrsw	x3, [x0, #0xc]
               	add	x1, x1, x3
               	cmp	w1, #0x12
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1, #0x28]
               	ldrsw	x4, [x1, #0x2c]
               	add	x3, x3, x4
               	ldrsw	x4, [x1, #0x8]
               	add	x3, x3, x4
               	ldrsw	x1, [x1, #0xc]
               	add	x1, x3, x1
               	cmp	w1, #0x12
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0]
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0x1c]
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0, #0x4]
               	ldrsw	x4, [x0, #0xc]
               	add	x3, x3, x4
               	ldrsw	x4, [x0, #0x14]
               	add	x3, x3, x4
               	ldrsw	x0, [x0, #0x1c]
               	add	x0, x3, x0
               	cmp	w0, #0xd
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x18]
               	cbnz	x0, <addr>
               	mov	x0, x1
               	mov	x0, x1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<member_array_forms>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0x8]
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0xc]
               	add	x1, x1, x2
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	ldrsw	x3, [x1, #0x4]
               	add	x2, x2, x3
               	ldrsw	x3, [x1, #0x8]
               	add	x2, x2, x3
               	ldrsw	x1, [x1, #0xc]
               	add	x1, x2, x1
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	ldrsw	x1, [x0]
               	cbnz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	cmp	w2, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	mov	x2, x1
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x4
               	b.ne	<addr>
               	mov	x0, x1
               	mov	x0, x1
               	ret
               	mov	x0, #0x14               // =20
               	ret
               	mov	x0, #0x13               // =19
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
