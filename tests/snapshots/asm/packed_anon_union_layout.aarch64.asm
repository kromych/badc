
packed_anon_union_layout.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x1c0]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x1b0]
               	add	x29, sp, #0x1b0
               	sub	x0, x29, #0x180
               	add	x1, x0, #0x80
               	sub	x0, x1, x0
               	cmp	x0, #0x80
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x1b0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	sub	x20, x29, #0x80
               	mov	x21, #0x0               // =0
               	mov	x2, #0x80               // =128
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x0, #0x3                // =3
               	str	w0, [x20]
               	mov	x0, #0x8                // =8
               	str	w0, [x20, #0x3c]
               	mov	x0, #0x14               // =20
               	str	w0, [x20, #0x44]
               	ldrb	w0, [x20]
               	mov	x17, #0x3               // =3
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x1b0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	ldrb	w0, [x20, #0x3c]
               	mov	x17, #0x8               // =8
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x1b0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	ldrb	w0, [x20, #0x44]
               	mov	x17, #0x14              // =20
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x1b0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x1b0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
