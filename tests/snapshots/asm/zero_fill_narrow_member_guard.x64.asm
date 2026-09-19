
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
               	movl	(%rdx), %edi
               	movq	%rcx, %rsi
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %r8
               	incq	%r8
               	movl	%r8d, (%rsi)
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rsi
               	cmpl	$0x2, %eax
               	jb	<addr>
               	movl	(%rdx), %eax
               	testb	$0x1, %al
               	movl	$0x1, %eax
               	jne	<addr>
               	movl	(%rdx), %eax
               	cmpl	%edi, %eax
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
               	movq	%rsi, %rax
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
