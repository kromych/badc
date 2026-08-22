
fn_ptr_float_arg_narrow.aarch64:	file format elf64-littleaarch64

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

<scale2>:
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	ret

<negf>:
               	fneg	s0, s0
               	ret

<addf>:
               	fadd	s0, s0, s1
               	ret

<main>:
               	str	x20, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x0, #0x40400000         // =1077936128
               	fmov	d0, x0
               	bl	<addr>
               	mov	x0, #0x40c00000         // =1086324736
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x20, #0x40400000        // =1077936128
               	fmov	d0, x20
               	bl	<addr>
               	fmov	s16, w20
               	fneg	s1, s16
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x40800000         // =1082130432
               	fmov	d0, x0
               	bl	<addr>
               	mov	x0, #0x41000000         // =1090519040
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x3fc00000         // =1069547520
               	mov	x1, #0x40000000         // =1073741824
               	fmov	d0, x0
               	fmov	d1, x1
               	bl	<addr>
               	mov	x0, #0x40600000         // =1080033280
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x40a00000         // =1084227584
               	mov	x1, #0x40000000         // =1073741824
               	fmov	s16, w0
               	fmov	s17, w1
               	fmul	s0, s16, s17
               	mov	x0, #0x41200000         // =1092616192
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x40e00000         // =1088421888
               	fmov	s16, w0
               	sub	x17, x29, #0x38
               	str	s16, [x17]
               	sub	x16, x29, #0x38
               	ldr	s0, [x16]
               	bl	<addr>
               	mov	x0, #0x41600000         // =1096810496
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x40400000         // =1077936128
               	fmov	d0, x0
               	bl	<addr>
               	mov	x0, #0x40c00000         // =1086324736
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x40400000         // =1077936128
               	fmov	d0, x0
               	bl	<addr>
               	mov	x0, #0x40c00000         // =1086324736
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x3fc00000         // =1069547520
               	mov	x1, #0x40000000         // =1073741824
               	fmov	d0, x0
               	fmov	d1, x1
               	bl	<addr>
               	mov	x0, #0x40600000         // =1080033280
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
