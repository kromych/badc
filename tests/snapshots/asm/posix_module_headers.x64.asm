
posix_module_headers.x64:	file format elf64-x86-64

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
               	subq	$0x1e8, %rsp            # imm = 0x1E8
               	movl	$0x41, %edi
               	callq	<addr>
               	cmpl	$0x41, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x1e8, %rsp            # imm = 0x1E8
               	retq
               	movl	$0x41, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x41, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x1e8, %rsp            # imm = 0x1E8
               	retq
               	movl	$0x41, %edi
               	callq	<addr>
               	movl	%eax, %eax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x1e8, %rsp            # imm = 0x1E8
               	retq
               	movl	$0x41, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x41, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x1e8, %rsp            # imm = 0x1E8
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %rsi
               	movl	$0x41, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x1e8, %rsp            # imm = 0x1E8
               	retq
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x1e8, %rsp            # imm = 0x1E8
               	retq
               	leaq	0x10(%rsp), %rdi
               	movl	$0xf, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x1e8, %rsp            # imm = 0x1E8
               	retq
               	leaq	0x10(%rsp), %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x1e8, %rsp            # imm = 0x1E8
               	retq
               	movl	$0x4, %edi
               	leaq	(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x1e8, %rsp            # imm = 0x1E8
               	retq
               	callq	<addr>
               	movl	$0x0, (%rax)
               	callq	<addr>
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	xorl	%eax, %eax
               	addq	$0x1e8, %rsp            # imm = 0x1E8
               	retq
               	movl	$0xf, %eax
               	addq	$0x1e8, %rsp            # imm = 0x1E8
               	retq
