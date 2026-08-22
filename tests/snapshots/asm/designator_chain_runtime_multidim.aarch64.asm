
designator_chain_runtime_multidim.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x30
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	mov	x1, #0x7                // =7
               	sub	x0, x29, #0x30
               	str	w1, [x0, #0x4]
               	mov	x1, #0x1e               // =30
               	sub	x0, x29, #0x30
               	str	w1, [x0, #0x8]
               	mov	x1, #0x28               // =40
               	sub	x0, x29, #0x30
               	str	w1, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x38
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	mov	x1, #0x7                // =7
               	sub	x0, x29, #0x38
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x38
               	mov	x1, #0x7                // =7
               	str	w1, [x0, #0x8]
               	mov	x1, #0x1                // =1
               	sub	x0, x29, #0x38
               	str	w1, [x0, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x38
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	mov	x1, #0x7                // =7
               	sub	x0, x29, #0x38
               	str	w1, [x0, #0x10]
               	mov	x1, #0x6                // =6
               	sub	x0, x29, #0x38
               	str	w1, [x0, #0x14]
               	mov	x1, #0x8                // =8
               	sub	x0, x29, #0x38
               	str	w1, [x0, #0x18]
               	mov	x1, #0x9                // =9
               	sub	x0, x29, #0x38
               	str	w1, [x0, #0x1c]
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x38
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	mov	x1, #0x7                // =7
               	sub	x0, x29, #0x38
               	str	w1, [x0, #0xc]
               	mov	x1, #0x2                // =2
               	sub	x0, x29, #0x38
               	str	w1, [x0, #0x10]
               	mov	x1, #0x3                // =3
               	sub	x0, x29, #0x38
               	str	w1, [x0, #0x14]
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
