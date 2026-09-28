
standard_streams_and_errno.x64:	file format elf64-x86-64

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

<__c5_lazy_stream>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	movslq	%edi, %rbx
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax,%rbx,8)
               	je	<addr>
               	movq	(%rax,%rbx,8), %rax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorl	%edi, %edi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx,%rbx,8)
               	leaq	<rip>, %rax
               	movq	(%rax,%rbx,8), %rax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	movl	$0x2, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	movl	$0x21, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x21, %rax
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	movl	$0xa, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	movl	$0xc, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jl	<addr>
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x78, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x0, (%rax)
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x22, (%rax)
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	(%rax), %rax
               	cmpl	$0x22, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
