
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x15, #0x4               // =4
               	mov	x14, #0x8               // =8
               	cmp	x15, #0x4
               	b.eq	<addr>
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x14, #0x8
               	b.eq	<addr>
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4               // =4
               	lsl	x15, x20, #2
               	sxtw	x21, w15
               	mov	x0, x21
               	bl	<addr>
               	mov	x22, x0
               	lsl	x20, x20, #3
               	sxtw	x20, w20
               	mov	x0, x20
               	bl	<addr>
               	mov	x23, x0
               	mov	x20, #0x3f800000        // =1065353216
               	str	w20, [x22]
               	add	x12, x22, #0x4
               	mov	x20, #0x40000000        // =1073741824
               	str	w20, [x12]
               	mov	x11, #0x3ff0000000000000 // =4607182418800017408
               	str	x11, [x23]
               	add	x20, x23, #0x8
               	mov	x11, #0x4000000000000000 // =4611686018427387904
               	str	x11, [x20]
               	ldrsw	x12, [x22]
               	mov	x17, #0x3f800000        // =1065353216
               	cmp	x12, x17
               	b.eq	<addr>
               	mov	x11, #0x3               // =3
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x12, x22, #0x4
               	ldrsw	x12, [x12]
               	mov	x17, #0x40000000        // =1073741824
               	cmp	x12, x17
               	b.eq	<addr>
               	mov	x11, #0x4               // =4
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x12, [x23]
               	mov	x17, #0x3ff0000000000000 // =4607182418800017408
               	cmp	x12, x17
               	b.eq	<addr>
               	mov	x11, #0x5               // =5
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x12, x23, #0x8
               	ldr	x12, [x12]
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	cmp	x12, x17
               	b.eq	<addr>
               	mov	x11, #0x6               // =6
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
