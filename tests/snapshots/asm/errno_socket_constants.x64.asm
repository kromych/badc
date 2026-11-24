
errno_socket_constants.x64:	file format elf64-x86-64

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
               	subq	$0x48, %rsp
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movups	0x30(%rcx), %xmm14
               	movups	%xmm14, 0x30(%rax)
               	xorl	%edx, %edx
               	movl	(%rsp,%rdx,4), %eax
               	testl	%eax, %eax
               	jle	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movl	(%rsp,%rdx,4), %esi
               	movl	(%rsp,%rax,4), %edi
               	cmpl	%edi, %esi
               	je	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x10, %edx
               	jl	<addr>
               	xorl	%eax, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	$0x2, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	$0x1, %eax
               	addq	$0x48, %rsp
               	retq
