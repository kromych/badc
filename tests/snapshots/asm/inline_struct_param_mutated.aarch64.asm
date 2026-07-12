
inline_struct_param_mutated.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x8
               	ldr	x1, [x1]
               	add	x1, x1, #0x64
               	str	x1, [x0]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x8
               	mov	x1, #0x5                // =5
               	str	x1, [x0]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	bl	<addr>
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	sub	x1, x29, #0x8
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	mov	x17, #0x9a2d            // =39469
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
