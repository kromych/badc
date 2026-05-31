
long_double_libc_return.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400318 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x20, x19
               	mov	x21, #0x0               // =0
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x4005a8 <strtold>
               	bl	0x4005b4 <__trunctfdf2>
               	fmov	x0, d0
               	mov	x21, #0x45f0000000000000 // =5039527983027585024
               	fmov	d0, x0
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x20, ne
               	cbz	x20, 0x400394 <.text+0x94>
               	mov	x21, #0xb               // =11
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x128
               	mov	x22, x19
               	mov	x20, #0x0               // =0
               	mov	x0, x22
               	mov	x1, x20
               	bl	0x4005a8 <strtold>
               	bl	0x4005b4 <__trunctfdf2>
               	fmov	x0, d0
               	mov	x20, #0x43f0000000000000 // =4895412794951729152
               	fmov	d0, x0
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x22, ne
               	cbz	x22, 0x4003f4 <.text+0xf4>
               	mov	x20, #0xc               // =12
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x3ff0000000000000 // =4607182418800017408
               	mov	x22, #0x35              // =53
               	fmov	d0, x21
               	mov	x0, x22
               	bl	0x4005c0 <ldexp>
               	fmov	x0, d0
               	mov	x22, #0x4340000000000000 // =4845873199050653696
               	fmov	d0, x0
               	fmov	d1, x22
               	fcmp	d0, d1
               	cset	x21, ne
               	cbz	x21, 0x400448 <.text+0x148>
               	mov	x22, #0xd               // =13
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
