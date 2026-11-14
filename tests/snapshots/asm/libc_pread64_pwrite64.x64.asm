
libc_pread64_pwrite64.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	leaq	-0x18(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	0x10(%rax), %r10d
               	movl	%r10d, 0x10(%rdi)
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	%r10, %rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0x10, %edx
               	xorl	%ecx, %ecx
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rsi
               	xorl	%ecx, %ecx
               	movq	$0x0, -0x28(%rbp)
               	movq	$0x0, -0x20(%rbp)
               	movl	$0x10, %edx
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, (%rsp)
               	leaq	-0x38(%rbp), %rsi
               	movl	$0x8, %edx
               	movl	$0x10, %ecx
               	movq	0x8(%rsp), %rdi
               	callq	*%rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rsi
               	movq	$0x0, -0x28(%rbp)
               	movq	$0x0, -0x20(%rbp)
               	movl	$0x8, %edx
               	movl	$0x10, %ecx
               	movq	(%rsp), %r11
               	movq	0x8(%rsp), %rdi
               	callq	*%r11
               	cmpq	$0x8, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
