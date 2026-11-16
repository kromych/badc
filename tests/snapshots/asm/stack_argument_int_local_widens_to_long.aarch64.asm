
stack_argument_int_local_widens_to_long.aarch64:	file format elf64-littleaarch64

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

<tail>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x6, x17
               	mov	x17, #0x64              // =100
               	mul	x1, x7, x17
               	add	x0, x0, x1
               	ldr	x1, [x29, #0x10]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldr	x1, [x29, #0x18]
               	add	x0, x0, x1
               	ldp	x29, x30, [sp], #0x10
               	ret

<pick>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	ldr	x0, [x29, #0x18]
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp, #0x10]
               	sxtw	x20, w0
               	neg	x0, x20
               	sxtw	x6, w0
               	mov	x17, #-0x2              // =-2
               	mul	x0, x20, x17
               	sxtw	x7, w0
               	mov	x17, #-0x3              // =-3
               	mul	x0, x20, x17
               	sxtw	x1, w0
               	mov	x17, #-0x4              // =-4
               	mul	x0, x20, x17
               	sxtw	x2, w0
               	mov	x0, #0x0                // =0
               	str	x1, [sp]
               	str	x2, [sp, #0x8]
               	mov	x1, x0
               	mov	x5, x0
               	mov	x4, x0
               	mov	x3, x0
               	mov	x2, x0
               	bl	<addr>
               	mov	x17, #-0x4d2            // =-1234
               	mul	x1, x20, x17
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x7fffffff        // =-2147483647
               	cmp	w20, #0x0
               	cset	x1, gt
               	sub	x1, x0, x1
               	mov	x0, #0x0                // =0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	mov	x1, x0
               	mov	x7, x0
               	mov	x6, x0
               	mov	x5, x0
               	mov	x4, x0
               	mov	x3, x0
               	mov	x2, x0
               	bl	<addr>
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
