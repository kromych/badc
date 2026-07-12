
ipproto_case_labels.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	cmp	x0, #0x32
               	b.lt	<addr>
               	cmp	x0, #0x3a
               	b.lt	<addr>
               	cmp	x0, #0x84
               	b.lt	<addr>
               	cmp	x0, #0x84
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x6                // =6
               	ret
               	cmp	x0, #0x3a
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	cmp	x0, #0x33
               	b.lt	<addr>
               	cmp	x0, #0x33
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	cmp	x0, #0x32
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	cmp	x0, #0x6
               	b.lt	<addr>
               	cmp	x0, #0x11
               	b.lt	<addr>
               	cmp	x0, #0x11
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x0, #0x6
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	x0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x11               // =17
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x32               // =50
               	bl	<addr>
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x33               // =51
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x84               // =132
               	bl	<addr>
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3a               // =58
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc8               // =200
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
