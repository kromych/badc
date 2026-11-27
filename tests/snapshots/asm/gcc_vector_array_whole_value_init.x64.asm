
gcc_vector_array_whole_value_init.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x68, %rsp
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	movabsq	$0x707070707070707, %rax # imm = 0x707070707070707
               	movq	%rax, (%rsp)
               	movzbq	(%rsp), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movabsq	$0x303030303030303, %rax # imm = 0x303030303030303
               	movq	%rax, 0x8(%rsp)
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	leaq	(%rsp), %rax
               	addq	$0x10, %rax
               	movups	%xmm0, (%rax)
               	movups	%xmm0, 0x20(%rsp)
               	movups	%xmm0, 0x20(%rsp)
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movl	$0x6, 0x30(%rsp)
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x68, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x68, %rsp
               	retq
               	movl	$0xa, %eax
               	addq	$0x68, %rsp
               	retq
