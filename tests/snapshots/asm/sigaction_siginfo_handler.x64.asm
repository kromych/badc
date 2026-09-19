
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
               	movq	0xa0(%rdx), %rdx
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	incq	%rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	movslq	(%rsi), %rcx
               	cmpl	%edi, %ecx
               	jne	<addr>
               	movl	%edi, (%rax)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	subq	%rdx, %rcx
               	cmpq	$0x100000, %rcx         # imm = 0x100000
               	setb	%cl
               	movzbq	%cl, %rcx
               	movl	%ecx, (%rax)
               	retq
               	movq	$-0x1, %rdi
               	jmp	<addr>

<check>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x138, %rsp            # imm = 0x138
               	pushq	%rbx
               	leaq	-0x130(%rbp), %rdi
               	xorl	%ebx, %ebx
               	movl	$0x98, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x130(%rbp), %rax
               	leaq	-<rip>, %rcx       # <addr>
               	movq	%rcx, (%rax)
               	movl	$0x4, 0x88(%rax)
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
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x98(%rbp), %rdi
               	xorl	%ebx, %ebx
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
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x98(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	-<rip>, %rdx      # <addr>
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movslq	0x88(%rax), %rax
               	testb	$0x4, %al
               	jne	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
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
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
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
