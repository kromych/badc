
call_stack_args_shared_area.aarch64:	file format elf64-littleaarch64

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

<sum10>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x0, x0, x7
               	ldr	x1, [x29, #0x10]
               	add	x0, x0, x1
               	ldr	x1, [x29, #0x18]
               	add	x0, x0, x1
               	ldp	x29, x30, [sp], #0x10
               	ret

<sum11>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x0, x0, x7
               	ldr	x1, [x29, #0x10]
               	add	x0, x0, x1
               	ldr	x1, [x29, #0x18]
               	add	x0, x0, x1
               	ldr	x1, [x29, #0x20]
               	add	x0, x0, x1
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp, #0x20]
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	mov	x6, #0x7                // =7
               	mov	x7, #0x8                // =8
               	adrp	x8, <page>
               	ldr	x9, [x8, #0x18]
               	mov	x16, #0x9               // =9
               	str	x16, [sp]
               	mov	x16, #0xa               // =10
               	str	x16, [sp, #0x8]
               	blr	x9
               	mov	x20, x0
               	mov	x0, #0xa                // =10
               	mov	x1, #0x9                // =9
               	mov	x2, #0x8                // =8
               	mov	x3, #0x7                // =7
               	mov	x4, #0x6                // =6
               	mov	x5, #0x5                // =5
               	mov	x6, #0x4                // =4
               	mov	x7, #0x3                // =3
               	adrp	x8, <page>
               	ldr	x9, [x8, #0x20]
               	mov	x16, #0x2               // =2
               	str	x16, [sp]
               	mov	x16, #0x1               // =1
               	str	x16, [sp, #0x8]
               	str	xzr, [sp, #0x10]
               	blr	x9
               	add	x0, x20, x0
               	sub	x0, x0, #0x6e
               	ldr	x20, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
