
variable_shift_rcx_loop.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x5, #0x0                // =0
               	mov	x4, x5
               	b	<addr>
               	add	x4, x5, x3
               	lsl	x6, x1, x2
               	add	x5, x5, x6
               	cmp	x4, x0
               	b.lt	<addr>
               	mov	x0, x3
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
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
