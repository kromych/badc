
stdio_line_input.x64:	file format elf64-x86-64

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
               	subq	$0x70, %rsp
               	pushq	%rbx
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	$0x0, 0x20(%rsp)
               	movq	$0x0, 0x28(%rsp)
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rcx
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	movl	$0x6, %edx
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rsi
               	xorl	%edi, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rcx
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	movl	$0x7, %edx
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rbx, %rdx
               	leaq	0x20(%rsp), %rdi
               	leaq	0x28(%rsp), %rsi
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movq	0x20(%rsp), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	0x28(%rsp), %rax
               	cmpq	$0x5, %rax
               	jae	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x20(%rsp), %rax
               	cmpb	$0x0, 0x4(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rdx
               	leaq	0x20(%rsp), %rdi
               	leaq	0x28(%rsp), %rsi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	0x20(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x5, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x20(%rsp), %rax
               	cmpb	$0x0, 0x5(%rax)
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rdx
               	leaq	0x20(%rsp), %rdi
               	leaq	0x28(%rsp), %rsi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movq	0x20(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x5, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rdx
               	leaq	0x20(%rsp), %rdi
               	leaq	0x28(%rsp), %rsi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rsi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	0x20(%rsp), %rdi
               	callq	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, 0x20(%rsp)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	$0x2, 0x28(%rsp)
               	movq	%rbx, %rcx
               	leaq	0x20(%rsp), %rdi
               	leaq	0x28(%rsp), %rsi
               	movl	$0x3a, %edx
               	callq	<addr>
               	cmpq	$0x6, %rax
               	jne	<addr>
               	movq	0x28(%rsp), %rax
               	cmpq	$0x7, %rax
               	jae	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	0x20(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x6, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x20(%rsp), %rax
               	cmpb	$0x0, 0x6(%rax)
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rcx
               	leaq	0x20(%rsp), %rdi
               	leaq	0x28(%rsp), %rsi
               	movl	$0x3a, %edx
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movq	0x20(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	0x20(%rsp), %rdi
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	testq	%r10, %r10
               	jne	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rdi
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	movl	$0x2a, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rdi
               	xorl	%esi, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	%rbx, %rdi
               	leaq	0x30(%rsp), %rsi
               	movl	$0x40, %edx
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	leaq	0x30(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x9, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x70, %rsp
               	retq
