
many_fp_args.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	sub	sp, sp, #0x20
               	ldr	x16, [sp, #0x20]
               	str	x16, [sp]
               	ldr	x16, [sp, #0x28]
               	str	x16, [sp, #0x10]
               	sub	sp, sp, #0x80
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	d8, [sp]
               	fadd	d0, d0, d1
               	fadd	d0, d0, d2
               	fadd	d0, d0, d3
               	fadd	d0, d0, d4
               	fadd	d0, d0, d5
               	fadd	d0, d0, d6
               	fadd	d0, d0, d7
               	ldr	d1, [x29, #0x90]
               	fadd	d0, d0, d1
               	ldr	d1, [x29, #0xa0]
               	fadd	d0, d0, d1
               	ldr	d8, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xa0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	mov	x2, #0x4008000000000000 // =4613937818241073152
               	mov	x3, #0x4010000000000000 // =4616189618054758400
               	mov	x4, #0x4014000000000000 // =4617315517961601024
               	mov	x5, #0x4018000000000000 // =4618441417868443648
               	mov	x6, #0x401c000000000000 // =4619567317775286272
               	mov	x7, #0x4020000000000000 // =4620693217682128896
               	mov	x8, #0x4022000000000000 // =4621256167635550208
               	mov	x9, #0x4024000000000000 // =4621819117588971520
               	sub	sp, sp, #0x10
               	str	x8, [sp]
               	str	x9, [sp, #0x8]
               	fmov	d0, x0
               	fmov	d1, x1
               	fmov	d2, x2
               	fmov	d3, x3
               	fmov	d4, x4
               	fmov	d5, x5
               	fmov	d6, x6
               	fmov	d7, x7
               	bl	<addr>
               	add	sp, sp, #0x10
               	mov	x0, #0x800000000000     // =140737488355328
               	movk	x0, #0x404b, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	mov	x1, #0x4059000000000000 // =4636737291354636288
               	mov	x2, #0x4069000000000000 // =4641240890982006784
               	sub	sp, sp, #0x10
               	str	x1, [sp]
               	str	x2, [sp, #0x8]
               	fmov	d0, x0
               	fmov	d1, x0
               	fmov	d2, x0
               	fmov	d3, x0
               	fmov	d4, x0
               	fmov	d5, x0
               	fmov	d6, x0
               	fmov	d7, x0
               	bl	<addr>
               	add	sp, sp, #0x10
               	mov	x0, #0x4073000000000000 // =4644055640749113344
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
