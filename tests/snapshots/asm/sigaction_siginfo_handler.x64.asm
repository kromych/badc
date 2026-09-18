
sigaction_siginfo_handler.x64:	file format elf64-x86-64

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

<on_usr1>:
               	leaq	<rip>, %rcx
               	movq	0xa0(%rdx), %r8
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rax
               	incq	%rax
               	movl	%eax, (%rdx)
               	leaq	<rip>, %rax
               	movslq	(%rsi), %rdx
               	cmpl	%edi, %edx
               	jne	<addr>
               	movl	%edi, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rcx), %rcx
               	subq	%r8, %rcx
               	cmpq	$0x100000, %rcx         # imm = 0x100000
               	setb	%cl
               	movzbq	%cl, %rcx
               	movl	%ecx, (%rax)
               	retq
               	movabsq	$-0x1, %rdi
               	jmp	<addr>

<check>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x140, %rsp            # imm = 0x140
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x130(%rbp), %rdi
               	xorq	%rbx, %rbx
               	movl	$0x98, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x130(%rbp), %rax
               	leaq	-<rip>, %r12       # <addr>
               	movq	%r12, (%rax)
               	movl	$0x4, %ecx
               	movl	%ecx, 0x88(%rax)
               	leaq	0x8(%rax), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0xa, %edi
               	leaq	-0x130(%rbp), %rsi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x98(%rbp), %rdi
               	xorq	%rbx, %rbx
               	movl	$0x98, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0xa, %edi
               	leaq	-0x98(%rbp), %rdx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x98(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	%r12, %rcx
               	jne	<addr>
               	movslq	0x88(%rax), %rax
               	andq	$0x4, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0xa, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x6, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, (%rax)
               	callq	<addr>
               	movslq	%eax, %rax
               	leave
               	retq
