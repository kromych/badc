
errno_socket_constants.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x40(%rbp), %rax
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
               	leaq	-0x40(%rbp), %rcx
               	movslq	(%rcx,%rdx,4), %rax
               	testl	%eax, %eax
               	jle	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movslq	(%rcx,%rdx,4), %rsi
               	movslq	(%rcx,%rax,4), %rdi
               	cmpl	%edi, %esi
               	je	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x10, %edx
               	jl	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq
