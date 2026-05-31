
double_int_initializer.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	ldr	x14, [x15]
               	mov	x15, #0x4059000000000000 // =4636737291354636288
               	fmov	d0, x14
               	fmov	d1, x15
               	fcmp	d0, d1
               	cset	x13, ne
               	cbz	x13, 0x400284 <.text+0x64>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd8
               	mov	x13, x19
               	ldr	x0, [x13]
               	mov	x13, #0x4014000000000000 // =4617315517961601024
               	fmov	d0, x13
               	fneg	d7, d0
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x13, ne
               	cbz	x13, 0x4002c4 <.text+0xa4>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x13, x19
               	ldr	x0, [x13]
               	mov	x13, #0x4014000000000000 // =4617315517961601024
               	fmov	d0, x0
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x14, ne
               	cbz	x14, 0x400300 <.text+0xe0>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
