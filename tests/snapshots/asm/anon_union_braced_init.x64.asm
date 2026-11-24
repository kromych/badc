
anon_union_braced_init.x64:	file format elf64-x86-64

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

<opaque>:
               	subq	$0x18, %rsp
               	movq	%rdi, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x70, %rsp
               	pushq	%rbx
               	movl	$0x7, 0x50(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, 0x58(%rsp)
               	movl	0x50(%rsp), %ebx
               	movq	0x58(%rsp), %rcx
               	leaq	0x60(%rsp), %rdi
               	movl	%ebx, %eax
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rcx, 0x18(%rsp)
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movl	(%rax), %edx
               	cmpl	%ebx, %edx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x20(%rsp), %rdi
               	movq	$0x1, 0x20(%rsp)
               	movq	%rax, 0x28(%rsp)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	leaq	0x30(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x40(%rsp), %rdi
               	movq	$0x5, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
