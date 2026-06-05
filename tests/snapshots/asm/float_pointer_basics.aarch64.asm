
float_pointer_basics.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x0, #0x4                // =4
               	mov	x1, #0x8                // =8
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x1, #0x8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4               // =4
               	lsl	x0, x20, #2
               	sxtw	x0, w0
               	bl	<addr>
               	mov	x21, x0
               	lsl	x0, x20, #3
               	sxtw	x0, w0
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x3f800000         // =1065353216
               	str	w0, [x21]
               	add	x0, x21, #0x4
               	mov	x1, #0x40000000         // =1073741824
               	str	w1, [x0]
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	str	x0, [x20]
               	add	x0, x20, #0x8
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	str	x1, [x0]
               	ldrsw	x0, [x21]
               	mov	x17, #0x3f800000        // =1065353216
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x21, #0x4
               	ldrsw	x0, [x0]
               	mov	x17, #0x40000000        // =1073741824
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x20]
               	mov	x17, #0x3ff0000000000000 // =4607182418800017408
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x20, #0x8
               	ldr	x0, [x0]
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
