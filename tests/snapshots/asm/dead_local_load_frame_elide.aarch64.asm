
dead_local_load_frame_elide.aarch64:	file format elf64-littleaarch64

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

<fold>:
               	ldr	x1, [x0]
               	rev	x0, x1
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
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	sub	x20, x29, #0x8
               	add	x0, x20, #0x0
               	mov	x21, #0x1               // =1
               	strb	w21, [x0]
               	mov	x22, #0x2               // =2
               	strb	w22, [x20, #0x1]
               	mov	x0, #0x3                // =3
               	strb	w0, [x20, #0x2]
               	mov	x0, #0x4                // =4
               	strb	w0, [x20, #0x3]
               	mov	x0, #0x5                // =5
               	strb	w0, [x20, #0x4]
               	mov	x0, #0x6                // =6
               	strb	w0, [x20, #0x5]
               	mov	x0, #0x7                // =7
               	strb	w0, [x20, #0x6]
               	mov	x0, #0x8                // =8
               	strb	w0, [x20, #0x7]
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #0x708             // =1800
               	movk	x17, #0x506, lsl #16
               	movk	x17, #0x304, lsl #32
               	movk	x17, #0x102, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, x22
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
