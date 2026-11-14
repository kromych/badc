
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
               	ldr	x0, [x0]
               	rev	x0, x0
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
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	mov	x1, #0x1                // =1
               	mov	x2, #0x201              // =513
               	sturh	w2, [x29, #-0x8]
               	mov	x2, #0x403              // =1027
               	sturh	w2, [x29, #-0x6]
               	mov	x2, #0x605              // =1541
               	sturh	w2, [x29, #-0x4]
               	mov	x2, #0x807              // =2055
               	sturh	w2, [x29, #-0x2]
               	ldur	x2, [x29, #-0x8]
               	rev	x2, x2
               	mov	x17, #0x708             // =1800
               	movk	x17, #0x506, lsl #16
               	movk	x17, #0x304, lsl #32
               	movk	x17, #0x102, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
