
dead_local_load_frame_elide.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x1, x0, #0x0
               	ldrb	w1, [x1]
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	lsl	x1, x1, #8
               	ldrb	w2, [x0, #0x1]
               	orr	x1, x1, x2
               	lsl	x1, x1, #8
               	ldrb	w2, [x0, #0x2]
               	orr	x1, x1, x2
               	lsl	x1, x1, #8
               	ldrb	w2, [x0, #0x3]
               	orr	x1, x1, x2
               	lsl	x1, x1, #8
               	ldrb	w2, [x0, #0x4]
               	orr	x1, x1, x2
               	lsl	x1, x1, #8
               	ldrb	w2, [x0, #0x5]
               	orr	x1, x1, x2
               	lsl	x1, x1, #8
               	ldrb	w2, [x0, #0x6]
               	orr	x1, x1, x2
               	lsl	x1, x1, #8
               	ldrb	w0, [x0, #0x7]
               	orr	x0, x1, x0
               	ret

<vol_keep>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldrb	w0, [x0]
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x8
               	add	x0, x0, #0x0
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	sub	x0, x29, #0x8
               	mov	x1, #0x2                // =2
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x8
               	mov	x1, #0x3                // =3
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x8
               	mov	x1, #0x4                // =4
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x8
               	mov	x1, #0x5                // =5
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x8
               	mov	x1, #0x6                // =6
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0x8
               	mov	x1, #0x7                // =7
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0x8
               	mov	x1, #0x8                // =8
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	mov	x17, #0x708             // =1800
               	movk	x17, #0x506, lsl #16
               	movk	x17, #0x304, lsl #32
               	movk	x17, #0x102, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
