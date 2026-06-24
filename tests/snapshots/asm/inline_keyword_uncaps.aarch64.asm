
inline_keyword_uncaps.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
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
               	add	x0, x0, #0x10
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
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
               	add	x0, x0, #0x10
               	mov	x1, #0x64               // =100
               	add	x1, x1, #0x1
               	add	x1, x1, #0x2
               	add	x1, x1, #0x3
               	add	x1, x1, #0x4
               	add	x1, x1, #0x5
               	add	x1, x1, #0x6
               	add	x1, x1, #0x7
               	add	x1, x1, #0x8
               	add	x1, x1, #0x9
               	add	x1, x1, #0xa
               	add	x1, x1, #0xb
               	add	x1, x1, #0xc
               	add	x1, x1, #0xd
               	add	x1, x1, #0xe
               	add	x1, x1, #0xf
               	add	x1, x1, #0x10
               	add	x0, x0, x1
               	cmp	x0, #0x174
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
