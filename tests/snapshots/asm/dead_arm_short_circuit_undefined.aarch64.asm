
dead_arm_short_circuit_undefined.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	mov	x1, #0x1                // =1
               	mov	x2, x1
               	mov	x2, x0
               	mov	x2, #0x5                // =5
               	mov	x2, x1
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, #0x7                // =7
               	mov	x2, x1
               	mov	x2, #0x5                // =5
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	mov	x2, x1
               	mov	x2, #0x1                // =1
               	mov	x2, x1
               	mov	x2, x1
               	mov	x2, x1
               	mov	x3, #0x7                // =7
               	mov	x2, x3
               	mov	x2, #0x1                // =1
               	str	x2, [x0]
               	str	x2, [x0, #0x8]
               	ldr	x4, [x0]
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	cbnz	x4, <addr>
               	cmp	x1, #0x1
               	cset	x0, ls
               	cbnz	x0, <addr>
               	mov	x0, x2
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	sub	x0, x29, #0x10
               	ldr	x2, [x0]
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	cbnz	x2, <addr>
               	mov	x2, x1
               	cmp	x2, #0x1
               	cset	x2, hi
               	cbz	x2, <addr>
               	mov	x2, x1
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	mov	x2, #0x2                // =2
               	str	x2, [x0, #0x8]
               	mov	x0, x1
               	mov	x0, #0x1                // =1
               	mov	x0, x1
               	mov	x0, x1
               	mov	x0, x1
               	mov	x3, #0x7                // =7
               	mov	x0, x3
               	sub	x0, x29, #0x10
               	mov	x2, #0x1                // =1
               	str	x2, [x0]
               	mov	x4, #0x3                // =3
               	str	x4, [x0, #0x8]
               	ldr	x4, [x0]
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	cbnz	x4, <addr>
               	cmp	x1, #0x1
               	cset	x1, ls
               	cbnz	x1, <addr>
               	mov	x1, x2
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	ldr	x2, [x0]
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	cbnz	x2, <addr>
               	mov	x2, x1
               	cmp	x2, #0x1
               	cset	x2, hi
               	cbz	x2, <addr>
               	mov	x2, x1
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	mov	x2, #0x4                // =4
               	str	x2, [x0, #0x8]
               	mov	x0, x1
               	mov	x0, #0x1                // =1
               	mov	x0, x1
               	mov	x0, x1
               	mov	x0, x1
               	mov	x3, #0x7                // =7
               	mov	x0, x3
               	sub	x0, x29, #0x10
               	mov	x2, #0x1                // =1
               	str	x2, [x0]
               	mov	x4, #0x5                // =5
               	str	x4, [x0, #0x8]
               	ldr	x4, [x0]
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	cbnz	x4, <addr>
               	cmp	x1, #0x1
               	cset	x1, ls
               	cbnz	x1, <addr>
               	mov	x1, x2
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	ldr	x2, [x0]
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	cbnz	x2, <addr>
               	mov	x2, x1
               	cmp	x2, #0x1
               	cset	x2, hi
               	cbz	x2, <addr>
               	mov	x2, x1
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	mov	x2, #0x6                // =6
               	str	x2, [x0, #0x8]
               	mov	x0, x1
               	mov	x0, #0x1                // =1
               	mov	x0, x1
               	mov	x0, x1
               	mov	x0, x1
               	mov	x0, #0x7                // =7
               	sub	x0, x29, #0x10
               	mov	x2, #0x1                // =1
               	str	x2, [x0]
               	mov	x3, #0x7                // =7
               	str	x3, [x0, #0x8]
               	ldr	x4, [x0]
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	cbnz	x4, <addr>
               	cmp	x1, #0x1
               	cset	x1, ls
               	cbnz	x1, <addr>
               	mov	x1, x2
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	ldr	x2, [x0]
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	cbnz	x2, <addr>
               	mov	x0, x1
               	cmp	x0, #0x1
               	cset	x0, hi
               	cbz	x0, <addr>
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	b	<addr>
