
switch_jump_table_sparse_kept.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x17, #0xa               // =10
               	mul	x0, x1, x17
               	sxtw	x0, w0
               	sxtw	x0, w0
               	cmp	x0, #0x32
               	b.lt	<addr>
               	cmp	x0, #0x46
               	b.lt	<addr>
               	cmp	x0, #0x50
               	b.lt	<addr>
               	cmp	x0, #0x5a
               	b.lt	<addr>
               	cmp	x0, #0x5a
               	b.eq	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	add	x3, x1, #0x1
               	sxtw	x3, w3
               	cmp	x0, x3
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0xa                // =10
               	b	<addr>
               	cmp	x0, #0x50
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	b	<addr>
               	cmp	x0, #0x46
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	b	<addr>
               	cmp	x0, #0x3c
               	b.lt	<addr>
               	cmp	x0, #0x3c
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	b	<addr>
               	cmp	x0, #0x32
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	cmp	x0, #0x14
               	b.lt	<addr>
               	cmp	x0, #0x1e
               	b.lt	<addr>
               	cmp	x0, #0x28
               	b.lt	<addr>
               	cmp	x0, #0x28
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	cmp	x0, #0x1e
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	cmp	x0, #0x14
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, #0xa
               	b.lt	<addr>
               	cmp	x0, #0xa
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0xa
               	b.lt	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	ret
               	b	<addr>
