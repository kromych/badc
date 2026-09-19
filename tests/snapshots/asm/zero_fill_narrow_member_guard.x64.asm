
zero_fill_narrow_member_guard.x64:	file format elf64-x86-64

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

<reader>:
               	xorl	%ecx, %ecx
               	movl	$0x2, %eax
               	leaq	<rip>, %rdx
               	movl	(%rdx), %esi
               	movq	%rcx, %r8
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %r8
               	incq	%r8
               	movl	%r8d, (%rdi)
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %r8
               	cmpl	$0x2, %eax
               	jb	<addr>
               	movl	(%rdx), %eax
               	movq	%rax, %rdi
               	andq	$0x1, %rdi
               	movl	$0x1, %eax
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	(%rdx), %eax
               	cmpl	%esi, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r8, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movl	$0x2, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x7, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movl	$0x3, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x9, (%rcx)
               	movl	$0x0, (%rax)
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
