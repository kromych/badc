
float_pointer_basics.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002c8 <.text+0x18>
               	adrp	x16, 0x410000
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
               	sxtw	x13, w15
               	cmp	x13, #0x4
               	b.eq	0x400324 <.text+0x74>
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
               	sxtw	x15, w14
               	cmp	x15, #0x8
               	b.eq	0x400358 <.text+0xa8>
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
               	sxtw	x15, w20
               	lsl	x14, x15, #2
               	sxtw	x21, w14
               	mov	x0, x21
               	bl	0x400618 <malloc>
               	mov	x22, x0
               	sxtw	x21, w20
               	lsl	x20, x21, #3
               	sxtw	x23, w20
               	mov	x0, x23
               	bl	0x400618 <malloc>
               	mov	x20, x0
               	mov	x23, #0x3f800000        // =1065353216
               	str	w23, [x22]
               	add	x12, x22, #0x4
               	mov	x23, #0x40000000        // =1073741824
               	str	w23, [x12]
               	mov	x11, #0x3ff0000000000000 // =4607182418800017408
               	str	x11, [x20]
               	add	x23, x20, #0x8
               	mov	x11, #0x4000000000000000 // =4611686018427387904
               	str	x11, [x23]
               	ldrsw	x12, [x22]
               	mov	x17, #0x3f800000        // =1065353216
               	cmp	x12, x17
               	b.eq	0x4003ec <.text+0x13c>
               	mov	x12, #0x3               // =3
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x11, x22, #0x4
               	ldrsw	x12, [x11]
               	mov	x17, #0x40000000        // =1073741824
               	cmp	x12, x17
               	b.eq	0x400428 <.text+0x178>
               	mov	x12, #0x4               // =4
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x11, [x20]
               	mov	x17, #0x3ff0000000000000 // =4607182418800017408
               	cmp	x11, x17
               	b.eq	0x400460 <.text+0x1b0>
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
               	add	x12, x20, #0x8
               	ldr	x11, [x12]
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	cmp	x11, x17
               	b.eq	0x40049c <.text+0x1ec>
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
               	bl	0x400624 <free>
               	sxtw	x0, w0
               	mov	x0, x20
               	bl	0x400624 <free>
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
