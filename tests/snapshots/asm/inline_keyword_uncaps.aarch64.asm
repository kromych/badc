
inline_keyword_uncaps.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x80
               	add	x0, x0, #0x1
               	add	x0, x0, #0x2
               	add	x0, x0, #0x3
               	add	x0, x0, #0x4
               	add	x0, x0, #0x5
               	add	x0, x0, #0x6
               	add	x0, x0, #0x7
               	add	x0, x0, #0x8
               	add	x0, x0, #0x9
               	add	x0, x0, #0xa
               	add	x0, x0, #0xb
               	add	x0, x0, #0xc
               	add	x0, x0, #0xd
               	add	x0, x0, #0xe
               	add	x0, x0, #0xf
               	add	x14, x0, #0x10
               	mov	x0, x14
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x1
               	add	x15, x15, #0x2
               	add	x15, x15, #0x3
               	add	x15, x15, #0x4
               	add	x15, x15, #0x5
               	add	x15, x15, #0x6
               	add	x15, x15, #0x7
               	add	x15, x15, #0x8
               	add	x15, x15, #0x9
               	add	x15, x15, #0xa
               	add	x15, x15, #0xb
               	add	x15, x15, #0xc
               	add	x15, x15, #0xd
               	add	x15, x15, #0xe
               	add	x15, x15, #0xf
               	add	x15, x15, #0x10
               	mov	x14, #0x64              // =100
               	add	x14, x14, #0x1
               	add	x14, x14, #0x2
               	add	x14, x14, #0x3
               	add	x14, x14, #0x4
               	add	x14, x14, #0x5
               	add	x14, x14, #0x6
               	add	x14, x14, #0x7
               	add	x14, x14, #0x8
               	add	x14, x14, #0x9
               	add	x14, x14, #0xa
               	add	x14, x14, #0xb
               	add	x14, x14, #0xc
               	add	x14, x14, #0xd
               	add	x14, x14, #0xe
               	add	x14, x14, #0xf
               	add	x14, x14, #0x10
               	add	x15, x15, x14
               	cmp	x15, #0x174
               	b.ne	<addr>
               	mov	x14, #0x0               // =0
               	stur	x14, [x29, #-0x18]
               	b	<addr>
               	mov	x14, #0x1               // =1
               	stur	x14, [x29, #-0x18]
               	b	<addr>
               	ldur	x0, [x29, #-0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
