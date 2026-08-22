
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
               	mov	x2, #0x7                // =7
               	str	w2, [x0, #0x4]
               	mov	x3, #0x1e               // =30
               	str	w3, [x0, #0x8]
               	mov	x3, #0x28               // =40
               	str	w3, [x0, #0xc]
               	mov	x0, x1
               	mov	x0, x1
               	mov	x0, x1
               	mov	x0, x1
               	mov	x0, x1
               	sub	x0, x29, #0x38
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	w2, [x0, #0x4]
               	str	w2, [x0, #0x8]
               	mov	x3, #0x1                // =1
               	str	w3, [x0, #0x10]
               	mov	x3, x1
               	mov	x3, x1
               	mov	x3, x1
               	mov	x3, x1
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	w2, [x0, #0x10]
               	mov	x2, #0x6                // =6
               	str	w2, [x0, #0x14]
               	mov	x2, #0x8                // =8
               	str	w2, [x0, #0x18]
               	mov	x2, #0x9                // =9
               	str	w2, [x0, #0x1c]
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	mov	x2, x1
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	mov	x2, #0x7                // =7
               	sub	x0, x29, #0x38
               	str	w2, [x0, #0xc]
               	mov	x2, #0x2                // =2
               	str	w2, [x0, #0x10]
               	mov	x2, #0x3                // =3
               	str	w2, [x0, #0x14]
               	mov	x0, x1
               	mov	x0, x1
               	mov	x0, x1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
