
indirect_call_six_args_spilled_target.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<do_cmp>:
               	mov	x0, #0x1                // =1
               	str	w0, [x1]
               	ldr	x0, [x2]
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	ldr	x1, [x4]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	add	x0, x0, x3
               	add	x0, x0, x5
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x50]
               	sub	x0, x29, #0x40
               	mov	x1, #0x3                // =3
               	stur	x1, [x29, #-0x30]
               	sub	x1, x29, #0x20
               	mov	x2, #0x7                // =7
               	stur	x2, [x29, #-0x10]
               	stur	wzr, [x29, #-0x48]
               	add	x2, x0, #0x10
               	add	x4, x1, #0x10
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x48
               	mov	x3, #0x5                // =5
               	mov	x5, #0x9                // =9
               	bl	<addr>
               	ldursw	x1, [x29, #-0x48]
               	add	x0, x0, x1
               	cmp	x0, #0xc0d
               	mov	x17, #0x1               // =1
               	csel	x0, xzr, x17, eq
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
