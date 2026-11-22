
indirect_call_imm_target_direct.aarch64:	file format elf64-littleaarch64

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

<fact>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	cmp	w0, #0x2
               	b.ge	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x0, #0x1
               	cmp	w1, #0x2
               	b.ge	<addr>
               	mov	x1, #0x1                // =1
               	mul	x0, x0, x1
               	b	<addr>
               	sub	x2, x1, #0x1
               	cmp	w2, #0x2
               	b.ge	<addr>
               	mov	x2, #0x1                // =1
               	mul	x1, x1, x2
               	b	<addr>
               	sub	x3, x2, #0x1
               	cmp	w3, #0x2
               	b.ge	<addr>
               	mov	x3, #0x1                // =1
               	mul	x2, x2, x3
               	b	<addr>
               	sub	x4, x3, #0x1
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x10]
               	str	x2, [sp, #0x8]
               	str	x3, [sp]
               	mov	x0, x4
               	bl	<addr>
               	mov	x4, x0
               	ldr	x0, [sp, #0x18]
               	ldr	x1, [sp, #0x10]
               	ldr	x2, [sp, #0x8]
               	ldr	x3, [sp]
               	mul	x3, x3, x4
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	w0, #0x78
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp], #0x10
               	ret
