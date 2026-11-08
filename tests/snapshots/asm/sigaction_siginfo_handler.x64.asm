
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
               	leaq	-0x130(%rbp), %rcx
               	movq	$0x0, -0x130(%rbp)
               	movq	$0x0, -0x128(%rbp)
               	movq	$0x0, -0x120(%rbp)
               	movq	$0x0, -0x118(%rbp)
               	movq	$0x0, -0x110(%rbp)
               	movq	$0x0, -0x108(%rbp)
               	movq	$0x0, -0x100(%rbp)
               	movq	$0x0, -0xf8(%rbp)
               	movq	$0x0, -0xf0(%rbp)
               	movq	$0x0, -0xe8(%rbp)
               	movq	$0x0, -0xe0(%rbp)
               	movq	$0x0, -0xd8(%rbp)
               	movq	$0x0, -0xd0(%rbp)
               	movq	$0x0, -0xc8(%rbp)
               	movq	$0x0, -0xc0(%rbp)
               	movq	$0x0, -0xb8(%rbp)
               	movq	$0x0, -0xb0(%rbp)
               	movq	$0x0, -0xa8(%rbp)
               	movq	$0x0, -0xa0(%rbp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, -0x130(%rbp)
               	movl	$0x4, -0xa8(%rbp)
               	leaq	0x8(%rcx), %rdi
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
               	leaq	-0x98(%rbp), %rdx
               	xorl	%esi, %esi
               	movq	%rsi, -0x98(%rbp)
               	movq	%rsi, -0x90(%rbp)
               	movq	%rsi, -0x88(%rbp)
               	movq	%rsi, -0x80(%rbp)
               	movq	%rsi, -0x78(%rbp)
               	movq	%rsi, -0x70(%rbp)
               	movq	%rsi, -0x68(%rbp)
               	movq	%rsi, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	%rsi, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rsi, -0x40(%rbp)
               	movq	%rsi, -0x38(%rbp)
               	movq	%rsi, -0x30(%rbp)
               	movq	%rsi, -0x28(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rsi, -0x18(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movl	$0xa, %edi
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
