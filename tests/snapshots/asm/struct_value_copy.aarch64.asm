
struct_value_copy.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x28
               	mov	x3, #0x1                // =1
               	str	w3, [x0]
               	mov	x4, #0x2                // =2
               	str	w4, [x0, #0x4]
               	ldr	w1, [x0]
               	ldr	w2, [x0, #0x4]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, x3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x0, x4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x3e8              // =1000
               	str	w3, [x0]
               	mov	x3, #0x7d0              // =2000
               	str	w3, [x0, #0x4]
               	mov	x1, #0x32               // =50
               	str	w1, [x0]
               	mov	x1, #0x3c               // =60
               	str	w1, [x0, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	ldrsw	x1, [x0]
               	cmp	w1, #0x32
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x3c
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
