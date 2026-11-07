
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
               	movq	0xa0(%rdx), %rax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	movl	(%rsi), %ecx
               	cmpl	%edi, %ecx
               	jne	<addr>
               	movl	%edi, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	subq	%rax, %rcx
               	cmpq	$0x100000, %rcx         # imm = 0x100000
               	setb	%al
               	movzbq	%al, %rax
               	movl	%eax, <rip> # <addr>
               	retq
               	movq	$-0x1, %rdi
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x140, %rsp            # imm = 0x140
               	leaq	-0x138(%rbp), %rax
               	movq	%rax, <rip> # <addr>
               	leaq	-0x130(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x98, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x130(%rbp), %rax
               	leaq	-<rip>, %rcx # <addr>
               	movq	%rcx, -0x130(%rbp)
               	movl	$0x4, -0xa8(%rbp)
               	leaq	0x8(%rax), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0xa, %edi
               	leaq	-0x130(%rbp), %rsi
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x98(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x98, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0xa, %edi
               	xorl	%esi, %esi
               	leaq	-0x98(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	-0x98(%rbp), %rax
               	leaq	-<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	-0x10(%rbp), %eax
               	testb	$0x4, %al
               	jne	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0xa, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	movslq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
