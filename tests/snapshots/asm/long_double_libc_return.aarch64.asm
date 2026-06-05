
long_double_libc_return.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	adrp	x0, <page>
               	add	x0, x0, #0x108
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	bl	<addr>
               	fmov	x0, d0
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	mov	x0, #0x45f0000000000000 // =5039527983027585024
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x128
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	bl	<addr>
               	fmov	x0, d0
               	fmov	d16, x0
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	mov	x0, #0x43f0000000000000 // =4895412794951729152
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x35               // =53
               	fmov	d0, x0
               	mov	x0, x1
               	bl	<addr>
               	fmov	x0, d0
               	fmov	d16, x0
               	sub	x17, x29, #0x18
               	str	d16, [x17]
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	mov	x0, #0x4340000000000000 // =4845873199050653696
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
