
struct_stat_abi_size.x64:	file format elf64-x86-64

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
               	subq	$0xb8, %rsp
               	pushq	%rbx
               	leaq	-0xa8(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	0x10(%rax), %r10d
               	movl	%r10d, 0x10(%rdi)
               	movzbq	0x14(%rax), %r10
               	movb	%r10b, 0x14(%rdi)
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movl	$0x10, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	-0xa8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x90(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x90, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x90(%rbp), %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0xa8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x90(%rbp), %rax
               	movq	0x30(%rax), %rcx
               	cmpq	$0x10, %rcx
               	je	<addr>
               	leaq	-0xa8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movslq	0x18(%rax), %rax
               	andq	$0xf000, %rax           # imm = 0xF000
               	cmpl	$0x8000, %eax           # imm = 0x8000
               	je	<addr>
               	leaq	-0xa8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xa8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
