
pointer_to_array_typedef_param_subscript.aarch64:	file format elf64-littleaarch64

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

<set_row>:
               	mov	x3, x0
               	lsl	x4, x1, #6
               	add	x0, x3, x4
               	add	x5, x0, #0x0
               	add	x6, x2, #0x0
               	str	x6, [x5]
               	add	x5, x2, #0x1
               	str	x5, [x0, #0x8]
               	add	x5, x2, #0x2
               	str	x5, [x0, #0x10]
               	add	x5, x2, #0x3
               	str	x5, [x0, #0x18]
               	add	x5, x2, #0x4
               	str	x5, [x0, #0x20]
               	add	x5, x2, #0x5
               	str	x5, [x0, #0x28]
               	add	x5, x2, #0x6
               	str	x5, [x0, #0x30]
               	add	x1, x2, #0x7
               	str	x1, [x0, #0x38]
               	mov	x0, #0x0                // =0
               	ret

<sum_row>:
               	mov	x2, x0
               	lsl	x3, x1, #6
               	add	x0, x2, x3
               	add	x4, x0, #0x0
               	ldr	x4, [x4]
               	add	x4, x4, #0x0
               	ldr	x5, [x0, #0x8]
               	add	x4, x4, x5
               	ldr	x5, [x0, #0x10]
               	add	x4, x4, x5
               	ldr	x5, [x0, #0x18]
               	add	x4, x4, x5
               	ldr	x5, [x0, #0x20]
               	add	x4, x4, x5
               	ldr	x5, [x0, #0x28]
               	add	x4, x4, x5
               	ldr	x5, [x0, #0x30]
               	add	x4, x4, x5
               	ldr	x0, [x0, #0x38]
               	add	x0, x4, x0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x140]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x130]
               	add	x29, sp, #0x130
               	mov	x21, #0x0               // =0
               	sub	x20, x29, #0x100
               	mov	x0, x20
               	mov	x2, x21
               	mov	x1, x21
               	bl	<addr>
               	mov	x22, #0x1               // =1
               	mov	x2, #0x64               // =100
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	mov	x23, #0x2               // =2
               	mov	x2, #0xc8               // =200
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	mov	x1, #0x3                // =3
               	mov	x2, #0x12c              // =300
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x1c
               	b.eq	<addr>
               	mov	x0, x22
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	sub	x20, x29, #0x100
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	cmp	x0, #0x65c
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	mov	x21, #0x3               // =3
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x97c
               	b.eq	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	ldr	x0, [x20, #0xc0]
               	cmp	x0, #0x12c
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
