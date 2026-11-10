
posix_module_headers.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1e0, %rsp            # imm = 0x1E0
               	movl	$0x41, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x41, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x41, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x41, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x41, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	%eax, %eax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x41, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x41, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rsi
               	movl	$0x41, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x1d0(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x1d0(%rbp), %rdi
               	movl	$0x2, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x1d0(%rbp), %rdi
               	movl	$0x2, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x1d0(%rbp), %rdi
               	movl	$0xf, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x1d0(%rbp), %rdi
               	movl	$0x2, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x1d0(%rbp), %rdi
               	movl	$0x2, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x4, %edi
               	leaq	-0x1e0(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x0, (%rax)
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0xf, %eax
               	leave
               	retq
