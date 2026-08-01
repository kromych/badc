
dead_arm_short_circuit_undefined.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x30
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, ls
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x40
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, ls
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x20
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, hi
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x7                // =7
               	sub	x0, x29, #0x30
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, hi
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x7                // =7
               	sub	x0, x29, #0x40
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, hi
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x7                // =7
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, ls
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, hi
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x7                // =7
               	sub	x0, x29, #0x10
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, ls
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, hi
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x7                // =7
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x2                // =2
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, ls
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, hi
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x7                // =7
               	sub	x0, x29, #0x10
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x3                // =3
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, ls
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, hi
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x7                // =7
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x4                // =4
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, ls
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, hi
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x7                // =7
               	sub	x0, x29, #0x10
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x5                // =5
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, ls
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, hi
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x7                // =7
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x6                // =6
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, ls
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, hi
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x7                // =7
               	sub	x0, x29, #0x10
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x7                // =7
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, ls
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	cset	x1, hi
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x7                // =7
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	b	<addr>
