
dead_local_load_frame_elide.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<fold>:
               	movq	(%rdi), %rax
               	bswapq	%rax
               	retq

<vol_keep>:
               	subq	$0x18, %rsp
               	movzbq	(%rdi), %rax
               	movq	%rax, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	movl	$0x9, %eax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x18, %rsp
               	movw	$0x201, 0x8(%rsp)       # imm = 0x201
               	movw	$0x403, 0xa(%rsp)       # imm = 0x403
               	movw	$0x605, 0xc(%rsp)       # imm = 0x605
               	movw	$0x807, 0xe(%rsp)       # imm = 0x807
               	movq	0x8(%rsp), %rax
               	bswapq	%rax
               	movabsq	$0x102030405060708, %r11 # imm = 0x102030405060708
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
