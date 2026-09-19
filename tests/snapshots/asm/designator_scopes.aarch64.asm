
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x8]
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0xc]
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0x10]
               	add	x1, x1, x2
               	cmp	w1, #0x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	ldrsw	x3, [x1, #0x8]
               	add	x2, x2, x3
               	ldrsw	x3, [x1, #0xc]
               	add	x2, x2, x3
               	ldrsw	x3, [x1, #0x10]
               	add	x2, x2, x3
               	cmp	w2, #0x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x2, [x0, #0x10]
               	cbnz	x2, <addr>
               	ldrsw	x2, [x1, #0x10]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x9
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0x8]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
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
               	sub	sp, sp, #0x20
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
               	ldrsw	x2, [x0, #0x2c]
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0x8]
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0xc]
               	add	x1, x1, x2
               	cmp	w1, #0x12
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1, #0x28]
               	ldrsw	x3, [x1, #0x2c]
               	add	x2, x2, x3
               	ldrsw	x3, [x1, #0x8]
               	add	x2, x2, x3
               	ldrsw	x1, [x1, #0xc]
               	add	x1, x2, x1
               	cmp	w1, #0x12
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0]
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0x1c]
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x4]
               	ldrsw	x2, [x0, #0xc]
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0x14]
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0x1c]
               	add	x1, x1, x2
               	cmp	w1, #0xd
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0, #0x18]
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
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
               	ldrsw	x3, [x1, #0xc]
               	add	x2, x2, x3
               	cmp	w2, #0x7
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	ldrsw	x2, [x0]
               	cbnz	x2, <addr>
               	ldrsw	x1, [x1]
               	cbnz	w1, <addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x4
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x14               // =20
               	ret
               	mov	x0, #0x13               // =19
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
