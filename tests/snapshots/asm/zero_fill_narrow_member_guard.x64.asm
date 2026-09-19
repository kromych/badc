
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
               	testl	%eax, %eax
               	je	<addr>
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
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %r12
               	movl	$0x2, (%r12)
               	leaq	<rip>, %r13
               	movl	$0x7, (%r13)
               	leaq	<rip>, %rbx
               	movl	$0x0, (%rbx)
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rbx), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x3, (%r12)
               	movl	$0x9, (%r13)
               	movl	$0x0, (%rbx)
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	(%rbx), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
