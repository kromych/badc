
sigaction_siginfo_handler.x64:	file format elf64-x86-64

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

<on_usr1>:
               	movslq	%edi, %rdi
               	movq	0xa0(%rdx), %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	movq	$-0x1, %rcx
               	movl	(%rsi), %edx
               	cmpl	%edi, %edx
               	cmoveq	%rdi, %rcx
               	movl	%ecx, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	subq	%rax, %rcx
               	cmpq	$0x100000, %rcx         # imm = 0x100000
               	setb	%al
               	movzbq	%al, %rax
               	movl	%eax, <rip> # <addr>
               	retq

<check>:
               	subq	$0x138, %rsp            # imm = 0x138
               	leaq	(%rsp), %rcx
               	movq	$0x0, (%rsp)
               	movq	$0x0, 0x8(%rsp)
               	movq	$0x0, 0x10(%rsp)
               	movq	$0x0, 0x18(%rsp)
               	movq	$0x0, 0x20(%rsp)
               	movq	$0x0, 0x28(%rsp)
               	movq	$0x0, 0x30(%rsp)
               	movq	$0x0, 0x38(%rsp)
               	movq	$0x0, 0x40(%rsp)
               	movq	$0x0, 0x48(%rsp)
               	movq	$0x0, 0x50(%rsp)
               	movq	$0x0, 0x58(%rsp)
               	movq	$0x0, 0x60(%rsp)
               	movq	$0x0, 0x68(%rsp)
               	movq	$0x0, 0x70(%rsp)
               	movq	$0x0, 0x78(%rsp)
               	movq	$0x0, 0x80(%rsp)
               	movq	$0x0, 0x90(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movq	$0x4, 0x88(%rsp)
               	leaq	0x8(%rcx), %rdi
               	callq	<addr>
               	movl	$0xa, %edi
               	leaq	(%rsp), %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x138, %rsp            # imm = 0x138
               	retq
               	leaq	0x98(%rsp), %rdx
               	xorl	%esi, %esi
               	movq	%rsi, 0x98(%rsp)
               	movq	%rsi, 0xa0(%rsp)
               	movq	%rsi, 0xa8(%rsp)
               	movq	%rsi, 0xb0(%rsp)
               	movq	%rsi, 0xb8(%rsp)
               	movq	%rsi, 0xc0(%rsp)
               	movq	%rsi, 0xc8(%rsp)
               	movq	%rsi, 0xd0(%rsp)
               	movq	%rsi, 0xd8(%rsp)
               	movq	%rsi, 0xe0(%rsp)
               	movq	%rsi, 0xe8(%rsp)
               	movq	%rsi, 0xf0(%rsp)
               	movq	%rsi, 0xf8(%rsp)
               	movq	%rsi, 0x100(%rsp)
               	movq	%rsi, 0x108(%rsp)
               	movq	%rsi, 0x110(%rsp)
               	movq	%rsi, 0x118(%rsp)
               	movq	%rsi, 0x120(%rsp)
               	movq	%rsi, 0x128(%rsp)
               	movl	$0xa, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x138, %rsp            # imm = 0x138
               	retq
               	movq	0x98(%rsp), %rax
               	leaq	-<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	0x120(%rsp), %eax
               	testb	$0x4, %al
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x138, %rsp            # imm = 0x138
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x138, %rsp            # imm = 0x138
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x138, %rsp            # imm = 0x138
               	retq
               	movslq	<rip>, %rax # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x6, %edx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	$0x138, %rsp            # imm = 0x138
               	retq

<main>:
               	subq	$0x18, %rsp
               	leaq	0x8(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	callq	<addr>
               	addq	$0x18, %rsp
               	retq
