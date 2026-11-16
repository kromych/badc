
float_pointer_basics.aarch64:	file format elf64-littleaarch64

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

<main>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x20               // =32
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, #0x3f800000         // =1065353216
               	movk	x0, #0x4000, lsl #48
               	str	x0, [x20]
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	str	x0, [x1]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	str	x0, [x1, #0x8]
               	ldrsw	x0, [x20]
               	mov	x17, #0x3f800000        // =1065353216
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	ldrsw	x0, [x20, #0x4]
               	mov	x17, #0x40000000        // =1073741824
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	str	x1, [sp, #0x18]
               	mov	x0, x20
               	bl	<addr>
               	ldr	x1, [sp, #0x18]
               	mov	x0, x1
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
