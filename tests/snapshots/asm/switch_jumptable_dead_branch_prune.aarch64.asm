
switch_jumptable_dead_branch_prune.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	cmp	x0, #0xa
               	b.hs	<addr>
               	adr	x17, <addr>
               	ldrsw	x16, [x17, x0, lsl #2]
               	add	x17, x17, x16
               	br	x17
               	udf	#0x28
               	udf	#0x38
               	udf	#0x40
               	udf	#0x48
               	udf	#0x50
               	udf	#0x58
               	udf	#0x60
               	udf	#0x68
               	udf	#0x70
               	udf	#0x78
               	mov	x0, #0xa                // =10
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret
               	mov	x0, #0x15               // =21
               	b	<addr>
               	mov	x0, #0x20               // =32
               	b	<addr>
               	mov	x0, #0x2b               // =43
               	b	<addr>
               	mov	x0, #0x36               // =54
               	b	<addr>
               	mov	x0, #0x41               // =65
               	b	<addr>
               	mov	x0, #0x4c               // =76
               	b	<addr>
               	mov	x0, #0x57               // =87
               	b	<addr>
               	mov	x0, #0x62               // =98
               	b	<addr>
               	mov	x0, #0x13               // =19
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	add	x0, x0, #0x0
               	lsl	x20, x0, #1
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	add	x0, x20, x0
               	lsl	x20, x0, #1
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	add	x0, x20, x0
               	lsl	x20, x0, #1
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	add	x0, x20, x0
               	lsl	x20, x0, #1
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	add	x0, x20, x0
               	lsl	x20, x0, #1
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	add	x0, x20, x0
               	lsl	x20, x0, #1
               	mov	x0, #0x6                // =6
               	bl	<addr>
               	add	x0, x20, x0
               	lsl	x20, x0, #1
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	add	x0, x20, x0
               	lsl	x20, x0, #1
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	add	x0, x20, x0
               	lsl	x20, x0, #1
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	add	x0, x20, x0
               	lsl	x20, x0, #1
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	add	x0, x20, x0
               	lsl	x20, x0, #1
               	mov	x0, #0xb                // =11
               	bl	<addr>
               	add	x0, x20, x0
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
