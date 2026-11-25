
posix_os_headers.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x78, %rsp
               	leaq	0x20(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x78, %rsp
               	retq
               	movq	0x20(%rsp), %rax
               	cmpq	$0x6553f100, %rax       # imm = 0x6553F100
               	jge	<addr>
               	movl	$0x2, %eax
               	addq	$0x78, %rsp
               	retq
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x78, %rsp
               	retq
               	movl	0xc(%rsp), %edi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x78, %rsp
               	retq
               	movl	0x8(%rsp), %eax
               	movl	%eax, 0x10(%rsp)
               	movl	$0x1, 0x14(%rsp)
               	leaq	0x10(%rsp), %rdi
               	movl	$0x1, %esi
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x78, %rsp
               	retq
               	movswq	0x16(%rsp), %rax
               	testb	$0x1, %al
               	jne	<addr>
               	movl	$0x6, %eax
               	addq	$0x78, %rsp
               	retq
               	movl	0x8(%rsp), %edi
               	callq	<addr>
               	movl	0xc(%rsp), %edi
               	callq	<addr>
               	xorl	%edi, %edi
               	leaq	0x30(%rsp), %rsi
               	callq	<addr>
               	xorl	%edi, %edi
               	movl	$0x5413, %esi           # imm = 0x5413
               	leaq	0x18(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	addq	$0x78, %rsp
               	retq
