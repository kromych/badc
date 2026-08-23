
for_init_decl_in_loop.aarch64:	file format elf64-littleaarch64

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

<run>:
               	mov	x2, #0x0                // =0
               	mov	x1, #0x1                // =1
               	mov	x4, #0x64               // =100
               	b	<addr>
               	mul	x0, x1, x4
               	add	x3, x0, #0x0
               	add	x2, x2, x3
               	add	x3, x0, #0x1
               	add	x2, x2, x3
               	add	x3, x0, #0x2
               	add	x2, x2, x3
               	add	x3, x0, #0x3
               	add	x2, x2, x3
               	add	x3, x0, #0x4
               	add	x2, x2, x3
               	add	x3, x0, #0x5
               	add	x2, x2, x3
               	add	x3, x0, #0x6
               	add	x2, x2, x3
               	add	x3, x0, #0x7
               	add	x2, x2, x3
               	add	x3, x0, #0x8
               	add	x2, x2, x3
               	add	x3, x0, #0x9
               	add	x2, x2, x3
               	add	x3, x0, #0xa
               	add	x2, x2, x3
               	add	x3, x0, #0xb
               	add	x2, x2, x3
               	add	x3, x0, #0xc
               	add	x2, x2, x3
               	add	x3, x0, #0xd
               	add	x2, x2, x3
               	add	x3, x0, #0xe
               	add	x2, x2, x3
               	add	x0, x0, #0xf
               	add	x2, x2, x0
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	cmp	w1, #0x5
               	b.lt	<addr>
               	sxtw	x0, w2
               	ret

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
