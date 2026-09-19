
many_fp_args.aarch64:	file format elf64-littleaarch64

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
               	fadd	d0, d0, d1
               	fadd	d0, d0, d2
               	fadd	d0, d0, d3
               	fadd	d0, d0, d4
               	fadd	d0, d0, d5
               	fadd	d0, d0, d6
               	fadd	d0, d0, d7
               	ldr	d1, [x29, #0x10]
               	fadd	d0, d0, d1
               	ldr	d1, [x29, #0x18]
               	fadd	d0, d0, d1
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	d8, d9, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	fmov	d0, #1.00000000
               	fmov	d1, #2.00000000
               	fmov	d2, #3.00000000
               	fmov	d3, #4.00000000
               	fmov	d4, #5.00000000
               	fmov	d5, #6.00000000
               	fmov	d6, #7.00000000
               	fmov	d7, #8.00000000
               	fmov	d8, #9.00000000
               	fmov	d9, #10.00000000
               	sub	sp, sp, #0x10
               	str	d8, [sp]
               	str	d9, [sp, #0x8]
               	bl	<addr>
               	add	sp, sp, #0x10
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x20
               	ret
               	fmov	d0, #0.50000000
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d1, x16
               	mov	x16, #0x4069000000000000 // =4641240890982006784
               	fmov	d2, x16
               	sub	sp, sp, #0x10
               	str	d1, [sp]
               	str	d2, [sp, #0x8]
               	fmov	d1, d0
               	fmov	d7, d0
               	fmov	d6, d0
               	fmov	d5, d0
               	fmov	d4, d0
               	fmov	d3, d0
               	fmov	d2, d0
               	bl	<addr>
               	add	sp, sp, #0x10
               	mov	x16, #0x4073000000000000 // =4644055640749113344
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x20
               	ret
