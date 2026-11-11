
ulimit_reports_the_file_size_limit.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x1, %edi
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, %rdx
               	shrq	$0x9, %rdx
               	cmpq	$-0x1, %rax
               	movq	%rdx, %r12
               	cmoveq	%rcx, %r12
               	movl	$0x1, %edi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpq	%r12, %rbx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x2, %edi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
