
pointer_to_array_typedef_param_subscript.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	lsl	x3, x1, #6
               	add	x3, x0, x3
               	add	x3, x3, #0x0
               	add	x4, x2, #0x0
               	str	x4, [x3]
               	lsl	x3, x1, #6
               	add	x3, x0, x3
               	add	x4, x2, #0x1
               	str	x4, [x3, #0x8]
               	lsl	x3, x1, #6
               	add	x3, x0, x3
               	add	x4, x2, #0x2
               	str	x4, [x3, #0x10]
               	lsl	x3, x1, #6
               	add	x3, x0, x3
               	add	x4, x2, #0x3
               	str	x4, [x3, #0x18]
               	lsl	x3, x1, #6
               	add	x3, x0, x3
               	add	x4, x2, #0x4
               	str	x4, [x3, #0x20]
               	lsl	x3, x1, #6
               	add	x3, x0, x3
               	add	x4, x2, #0x5
               	str	x4, [x3, #0x28]
               	lsl	x3, x1, #6
               	add	x3, x0, x3
               	add	x4, x2, #0x6
               	str	x4, [x3, #0x30]
               	lsl	x1, x1, #6
               	add	x0, x0, x1
               	add	x1, x2, #0x7
               	str	x1, [x0, #0x38]
               	mov	x0, #0x0                // =0
               	ret

<sum_row>:
               	lsl	x2, x1, #6
               	add	x2, x0, x2
               	add	x2, x2, #0x0
               	ldr	x2, [x2]
               	add	x3, x2, #0x0
               	lsl	x2, x1, #6
               	add	x2, x0, x2
               	ldr	x2, [x2, #0x8]
               	add	x3, x3, x2
               	lsl	x2, x1, #6
               	add	x2, x0, x2
               	ldr	x2, [x2, #0x10]
               	add	x3, x3, x2
               	lsl	x2, x1, #6
               	add	x2, x0, x2
               	ldr	x2, [x2, #0x18]
               	add	x3, x3, x2
               	lsl	x2, x1, #6
               	add	x2, x0, x2
               	ldr	x2, [x2, #0x20]
               	add	x3, x3, x2
               	lsl	x2, x1, #6
               	add	x2, x0, x2
               	ldr	x2, [x2, #0x28]
               	add	x3, x3, x2
               	lsl	x2, x1, #6
               	add	x2, x0, x2
               	ldr	x2, [x2, #0x30]
               	add	x2, x3, x2
               	lsl	x1, x1, #6
               	add	x0, x0, x1
               	ldr	x0, [x0, #0x38]
               	add	x0, x2, x0
               	ret

<first_of>:
               	lsl	x1, x1, #6
               	add	x0, x0, x1
               	ldr	x0, [x0]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x120
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0x100
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	mov	x1, #0x1                // =1
               	sub	x0, x29, #0x100
               	mov	x2, #0x64               // =100
               	bl	<addr>
               	mov	x1, #0x2                // =2
               	sub	x0, x29, #0x100
               	mov	x2, #0xc8               // =200
               	bl	<addr>
               	mov	x1, #0x3                // =3
               	sub	x0, x29, #0x100
               	mov	x2, #0x12c              // =300
               	bl	<addr>
               	sub	x0, x29, #0x100
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x1c
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x100
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	cmp	x0, #0x65c
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x100
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x97c
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x100
               	ldr	x0, [x0, #0xc0]
               	cmp	x0, #0x12c
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
