
variable_shift_rcx_loop.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x4, x0
               	mov	x5, x1
               	mov	x6, x2
               	mov	x2, x3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	add	x1, x0, x2
               	lsl	x3, x5, x6
               	add	x0, x0, x3
               	cmp	x1, x4
               	b.lt	<addr>
               	mov	x0, x2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x64               // =100
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
