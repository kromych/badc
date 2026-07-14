
struct_field_displacement.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	w1, [x0, #0x4]
               	mov	x0, #0x0                // =0
               	ret

<set_c>:
               	str	x1, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	ret

<rmw_b>:
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x2, x1
               	str	w1, [x0, #0x4]
               	mov	x0, #0x0                // =0
               	ret

<rmw_c>:
               	ldr	x2, [x0, #0x8]
               	add	x1, x2, x1
               	str	x1, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	ret

<rmw_d>:
               	ldrb	w1, [x0, #0x12]
               	add	x1, x1, #0x1
               	strb	w1, [x0, #0x12]
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	str	x20, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x0, x29, #0x18
               	mov	x20, #0x1               // =1
               	str	w20, [x0]
               	sub	x0, x29, #0x18
               	mov	x1, #0x16               // =22
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x18
               	mov	x1, #0x14d              // =333
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x18
               	mov	x1, #0x2c               // =44
               	strh	w1, [x0, #0x10]
               	sub	x0, x29, #0x18
               	mov	x1, #0x5                // =5
               	strb	w1, [x0, #0x12]
               	sub	x0, x29, #0x18
               	mov	x1, #0x63               // =99
               	bl	<addr>
               	sub	x0, x29, #0x18
               	mov	x1, #0x309              // =777
               	bl	<addr>
               	sub	x0, x29, #0x18
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x18
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	sub	x0, x29, #0x18
               	bl	<addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x313
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	sub	x0, x29, #0x18
               	ldrsh	x0, [x0, #0x10]
               	cmp	x0, #0x2c
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	sub	x0, x29, #0x18
               	ldrb	w0, [x0, #0x12]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
