
return_int_widens_to_double.aarch64:	file format elf64-littleaarch64

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
               	str	x19, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, #0x900000000000     // =158329674399744
               	movk	x0, #0x407f, lsl #48
               	fmov	d16, x0
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	ret
               	mov	x1, #0x800000000000     // =140737488355328
               	movk	x1, #0x407f, lsl #48
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.mi	<addr>
               	mov	x1, #0xa00000000000     // =175921860444160
               	movk	x1, #0x407f, lsl #48
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	ret
               	mov	x0, #-0x4010000000000000 // =-4616189618054758400
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x1
               	fneg	d0, d16
               	fmov	d16, x0
               	fcmp	d16, d0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	ret
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	ret
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x10
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0x900000000000    // =158329674399744
               	movk	x17, #0x407f, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	ret
