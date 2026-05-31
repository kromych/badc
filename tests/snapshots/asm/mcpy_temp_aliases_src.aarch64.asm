
mcpy_temp_aliases_src.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	str	x19, [sp]
               	mov	x15, #0x1               // =1
               	mov	x14, #0x2               // =2
               	mov	x13, #0x3               // =3
               	mov	x12, #0x4               // =4
               	mov	x11, #0x5               // =5
               	mov	x10, #0x6               // =6
               	mov	x9, #0x7                // =7
               	mov	x8, #0x8                // =8
               	mov	x7, #0x9                // =9
               	mov	x6, #0xa                // =10
               	add	x15, x15, x14
               	sxtw	x15, w15
               	add	x15, x15, x13
               	sxtw	x15, w15
               	add	x15, x15, x12
               	sxtw	x15, w15
               	add	x15, x15, x11
               	sxtw	x15, w15
               	add	x15, x15, x10
               	sxtw	x15, w15
               	add	x15, x15, x9
               	sxtw	x15, w15
               	add	x15, x15, x8
               	sxtw	x15, w15
               	add	x15, x15, x7
               	sxtw	x15, w15
               	add	x15, x15, x6
               	sxtw	x15, w15
               	sub	x6, x29, #0x20
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x7, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x7]
               	str	x10, [x6]
               	ldr	x10, [x7, #0x8]
               	str	x10, [x6, #0x8]
               	ldr	x10, [x7, #0x10]
               	str	x10, [x6, #0x10]
               	ldr	x10, [x7, #0x18]
               	str	x10, [x6, #0x18]
               	ldr	x10, [sp], #0x10
               	sxtw	x15, w15
               	cmp	x15, #0x37
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x20
               	ldr	x15, [x15]
               	mov	x17, #0x1111            // =4369
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x20
               	add	x15, x15, #0x8
               	ldr	x15, [x15]
               	mov	x17, #0x2222            // =8738
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x20
               	add	x15, x15, #0x10
               	ldr	x15, [x15]
               	mov	x17, #0x3333            // =13107
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x20
               	add	x15, x15, #0x18
               	ldr	x15, [x15]
               	mov	x17, #0x4444            // =17476
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
