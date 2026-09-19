
indirect_call_six_args_spilled_target.aarch64:	file format elf64-littleaarch64

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
               	sub	x0, x29, #0x50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0]
               	sub	x2, x29, #0x48
               	mov	x1, #0x3                // =3
               	str	x1, [x2, #0x10]
               	sub	x4, x29, #0x28
               	mov	x1, #0x7                // =7
               	str	x1, [x4, #0x10]
               	mov	x3, #0x5                // =5
               	mov	x5, #0x9                // =9
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x8]
               	ldr	x6, [x0]
               	sub	x1, x29, #0x8
               	add	x2, x2, #0x10
               	add	x4, x4, #0x10
               	blr	x6
               	ldursw	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	cmp	x0, #0xc0d
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
