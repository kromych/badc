
queens.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	movslq	%edx, %rdx
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	movslq	%edi, %rsi
               	cmpq	%rcx, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edi, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rdi
               	jmp	<addr>
               	movslq	%edi, %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movslq	%r8d, %r8
               	shlq	$0x2, %rsi
               	addq	%rax, %rsi
               	movslq	(%rsi), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movslq	%esi, %r9
               	movslq	%r9d, %rsi
               	cmpq	$0x0, %rsi
               	jge	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	retq
               	movslq	%r9d, %rsi
               	imulq	$-0x1, %rsi, %r9
               	jmp	<addr>
               	movslq	%edi, %rsi
               	shlq	$0x2, %rsi
               	addq	%rax, %rsi
               	movslq	(%rsi), %rsi
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	%r8d, %rsi
               	movslq	%r9d, %r8
               	cmpq	%r8, %rsi
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movslq	%r12d, %r12
               	cmpq	$0x8, %r12
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %r15
               	jmp	<addr>
               	movslq	%r14d, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%r14d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r14
               	jmp	<addr>
               	movslq	%r14d, %rdx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	%r15d, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	%r12, %rax
               	shlq	$0x2, %rax
               	addq	%rbx, %rax
               	movslq	%r14d, %rcx
               	movl	%ecx, (%rax)
               	movslq	%r15d, %r15
               	movq	%r12, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%r15, %rax
               	movslq	%eax, %r15
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x20(%rbp), %rdi
               	xorq	%rsi, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x5c, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
