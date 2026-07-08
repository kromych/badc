
float_pointer_basics.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x20               // =32
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x3f800000         // =1065353216
               	str	w0, [x20]
               	mov	x0, #0x40000000         // =1073741824
               	str	w0, [x20, #0x4]
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	str	x0, [x21]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	str	x0, [x21, #0x8]
               	ldrsw	x0, [x20]
               	mov	x17, #0x3f800000        // =1065353216
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ldrsw	x0, [x20, #0x4]
               	mov	x17, #0x40000000        // =1073741824
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ldr	x0, [x21]
               	mov	x17, #0x3ff0000000000000 // =4607182418800017408
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ldr	x0, [x21, #0x8]
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
