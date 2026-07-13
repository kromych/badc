
param_fp_before_int_pressure.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	mul	x0, x0, x17
               	mov	x17, #0x2710            // =10000
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	ldrsw	x1, [x3]
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	mov	x17, #0xa               // =10
               	mul	x1, x4, x17
               	add	x0, x0, x1
               	add	x0, x0, x5
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	ldrsw	x0, [x1]
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	mov	x17, #0xe078            // =57464
               	movk	x17, #0x1, lsl #16
               	add	x0, x0, x17
               	add	x0, x0, #0x28
               	add	x0, x0, #0x5
               	sxtw	x1, w0
               	sxtw	x0, w1
               	mov	x17, #0xe361            // =58209
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
