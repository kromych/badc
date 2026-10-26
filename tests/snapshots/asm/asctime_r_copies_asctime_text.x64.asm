
asctime_r_copies_asctime_text.x64:	file format elf64-x86-64

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
               	subq	$0x60, %rsp
               	leaq	-0x38(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movq	$0x0, 0x30(%rax)
               	movl	$0x46, -0x24(%rbp)
               	movl	$0xf, -0x2c(%rbp)
               	movl	$0x4, -0x20(%rbp)
               	movl	$0xe, -0x1c(%rbp)
               	movl	$0xd, -0x30(%rbp)
               	movl	$0x4, -0x34(%rbp)
               	movl	$0x5, -0x38(%rbp)
               	movq	<rip>, %rax # <addr>
               	leaq	-0x38(%rbp), %rdi
               	callq	*%rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdi
               	movl	$0x78, %esi
               	movl	$0x1a, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x58(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x58(%rbp), %rdi
               	cmpq	%rdi, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	movl	$0xb, -0x28(%rbp)
               	movl	$0x1f, -0x2c(%rbp)
               	leaq	-0x58(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
