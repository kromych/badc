
for_init_decl_in_loop.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x0                // =0
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x17, #0x64              // =100
               	mul	x2, x0, x17
               	add	x2, x2, #0x0
               	add	x1, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x2, x0, x17
               	add	x2, x2, #0x1
               	add	x1, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x2, x0, x17
               	add	x2, x2, #0x2
               	add	x1, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x2, x0, x17
               	add	x2, x2, #0x3
               	add	x1, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x2, x0, x17
               	add	x2, x2, #0x4
               	add	x1, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x2, x0, x17
               	add	x2, x2, #0x5
               	add	x1, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x2, x0, x17
               	add	x2, x2, #0x6
               	add	x1, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x2, x0, x17
               	add	x2, x2, #0x7
               	add	x1, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x2, x0, x17
               	add	x2, x2, #0x8
               	add	x1, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x2, x0, x17
               	add	x2, x2, #0x9
               	add	x1, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x2, x0, x17
               	add	x2, x2, #0xa
               	add	x1, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x2, x0, x17
               	add	x2, x2, #0xb
               	add	x1, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x2, x0, x17
               	add	x2, x2, #0xc
               	add	x1, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x2, x0, x17
               	add	x2, x2, #0xd
               	add	x1, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x2, x0, x17
               	add	x2, x2, #0xe
               	add	x1, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x2, x0, x17
               	add	x2, x2, #0xf
               	add	x1, x1, x2
               	add	x0, x3, #0x1
               	sxtw	x3, w0
               	cmp	x3, #0x5
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	mov	x17, #0x4060            // =16480
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
