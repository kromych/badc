
indirect_call_six_args_spilled_target.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
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

<run>:
               	str	x19, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x5, x1
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x8]
               	ldr	x1, [x0]
               	sub	x6, x29, #0x8
               	add	x5, x5, #0x10
               	add	x3, x3, #0x10
               	mov	x9, x1
               	mov	x1, x6
               	mov	x16, x4
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x5
               	mov	x5, x16
               	blr	x9
               	ldursw	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0]
               	sub	x0, x29, #0x28
               	mov	x1, #0x3                // =3
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x48
               	mov	x1, #0x7                // =7
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x28
               	mov	x2, #0x5                // =5
               	sub	x3, x29, #0x48
               	mov	x4, #0x9                // =9
               	bl	<addr>
               	cmp	x0, #0xc0d
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
