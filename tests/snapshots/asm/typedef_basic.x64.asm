
typedef_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	addq	%rsi, %rdi
               	movslq	%edi, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movl	$0x64, %r8d
               	movl	$0x41, %eax
               	movl	$0x499602d2, %ecx       # imm = 0x499602D2
               	leaq	<rip>, %rdx
               	leaq	-0x30(%rbp), %rsi
               	movl	$0x7, %edi
               	movl	%edi, (%rsi)
               	leaq	-0x30(%rbp), %rsi
               	addq	$0x8, %rsi
               	xorq	%rdi, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x38(%rbp), %rsi
               	movl	$0xb, %edi
               	movl	%edi, (%rsi)
               	leaq	-0x38(%rbp), %rsi
               	addq	$0x4, %rsi
               	movl	$0x16, %edi
               	movl	%edi, (%rsi)
               	leaq	-0x48(%rbp), %rsi
               	movl	$0x1, %edi
               	movl	%edi, (%rsi)
               	leaq	-0x48(%rbp), %rsi
               	addq	$0x4, %rsi
               	movl	$0x2, %edi
               	movl	%edi, (%rsi)
               	leaq	-0x48(%rbp), %rsi
               	addq	$0x8, %rsi
               	movl	$0x3, %edi
               	movl	%edi, (%rsi)
               	addq	%rax, %r8
               	movslq	%r8d, %rsi
               	cmpq	$0xa5, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rdx), %rdx
               	xorq	$0x68, %rdx
               	movl	%edx, %edx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0x7, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rdx
               	movslq	(%rdx), %rsi
               	leaq	-0x38(%rbp), %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rsi
               	movslq	%esi, %rdx
               	cmpq	$0x21, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rdx
               	movslq	(%rdx), %rsi
               	leaq	-0x48(%rbp), %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rsi
               	movslq	%esi, %rsi
               	leaq	-0x48(%rbp), %rdx
               	addq	$0x8, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rsi
               	movslq	%esi, %rdx
               	cmpq	$0x6, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x499602d2, %rcx       # imm = 0x499602D2
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x41, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x8, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x9, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
