
anon_member_inner_brace.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx      # <addr>
               	leaq	<rip>, %rax      # <addr>
               	movsbq	(%rcx), %rdx
               	movsbq	(%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movsbq	0x4(%rcx), %rdx
               	movsbq	0x4(%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movsbq	0x8(%rcx), %rdx
               	movsbq	0x8(%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	0xc(%rcx), %edx
               	movl	0xc(%rax), %esi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movsbq	0x10(%rcx), %rcx
               	movsbq	0x10(%rax), %rdx
               	cmpl	%edx, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movsbq	(%rcx), %rdx
               	movsbq	(%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movsbq	0x4(%rcx), %rdx
               	movsbq	0x4(%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movsbq	0x8(%rcx), %rdx
               	movsbq	0x8(%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	0xc(%rcx), %edx
               	movl	0xc(%rax), %esi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movsbq	0x10(%rcx), %rcx
               	movsbq	0x10(%rax), %rax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rcx), %edx
               	movl	(%rax), %esi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	0x4(%rcx), %edx
               	movl	0x4(%rax), %esi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	0x8(%rcx), %edx
               	movl	0x8(%rax), %esi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	0xc(%rcx), %edx
               	movl	0xc(%rax), %esi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	0x10(%rcx), %edx
               	movl	0x10(%rax), %esi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	0x14(%rcx), %ecx
               	movl	0x14(%rax), %edx
               	cmpl	%edx, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %edx
               	movl	(%rax), %esi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	0x4(%rcx), %edx
               	movl	0x4(%rax), %esi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	0x8(%rcx), %edx
               	movl	0x8(%rax), %esi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	0xc(%rcx), %edx
               	movl	0xc(%rax), %esi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	0x10(%rcx), %edx
               	movl	0x10(%rax), %esi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	0x14(%rcx), %ecx
               	movl	0x14(%rax), %eax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movzbq	0x8(%rax), %rcx
               	xorq	$0x7, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x9(%rax), %rcx
               	xorq	$0x8, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0xa(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movsbq	0x4(%rax), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movsbq	0x8(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movsbq	0x10(%rax), %rcx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movsbq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movsbq	0x4(%rax), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movsbq	0x8(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movsbq	0x10(%rax), %rcx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movsbq	(%rcx), %rdx
               	movsbq	(%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movsbq	0x4(%rcx), %rdx
               	movsbq	0x4(%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movsbq	0x8(%rcx), %rdx
               	movsbq	0x8(%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	0xc(%rcx), %edx
               	movl	0xc(%rax), %esi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movsbq	0x10(%rcx), %rcx
               	movsbq	0x10(%rax), %rax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorl	%eax, %eax
               	retq
