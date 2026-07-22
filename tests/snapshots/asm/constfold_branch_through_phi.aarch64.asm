
constfold_branch_through_phi.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x1                // =1
               	mov	x0, #0x8                // =8
               	mov	x0, #0x1                // =1
               	mov	x0, #0x2                // =2
               	mov	x0, #0xa                // =10
               	mov	x0, #0x64               // =100
               	mov	x0, #0x8                // =8
               	mov	x0, #0xa                // =10
               	mov	x0, #0x64               // =100
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x1                // =1
               	mov	x0, #0xa                // =10
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	ret
