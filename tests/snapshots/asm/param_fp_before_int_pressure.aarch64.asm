
param_fp_before_int_pressure.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
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
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x8]
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	sub	x4, x29, #0x8
               	mov	x5, #0x4                // =4
               	mov	x6, #0x5                // =5
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	mul	x0, x1, x17
               	mov	x17, #0x2710            // =10000
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x3, x17
               	add	x0, x0, x1
               	ldrsw	x1, [x4]
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	mov	x17, #0xa               // =10
               	mul	x1, x5, x17
               	add	x0, x0, x1
               	add	x0, x0, x6
               	sxtw	x0, w0
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
