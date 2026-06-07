
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
               	movq	%rdi, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movl	$0x64, %eax
               	movl	$0x41, %ecx
               	movl	$0x499602d2, %edx       # imm = 0x499602D2
               	leaq	<rip>, %rsi
               	leaq	-0x30(%rbp), %rdi
               	movl	$0x7, %r8d
               	movl	%r8d, (%rdi)
               	leaq	-0x30(%rbp), %rdi
               	xorq	%r8, %r8
               	movq	%r8, 0x8(%rdi)
               	leaq	-0x38(%rbp), %rdi
               	movl	$0xb, %r8d
               	movl	%r8d, (%rdi)
               	leaq	-0x38(%rbp), %rdi
               	movl	$0x16, %r8d
               	movl	%r8d, 0x4(%rdi)
               	leaq	-0x48(%rbp), %rdi
               	movl	$0x1, %r8d
               	movl	%r8d, (%rdi)
               	leaq	-0x48(%rbp), %rdi
               	movl	$0x2, %r8d
               	movl	%r8d, 0x4(%rdi)
               	leaq	-0x48(%rbp), %rdi
               	movl	$0x3, %r8d
               	movl	%r8d, 0x8(%rdi)
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0xa5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rsi), %rax
               	xorq	$0x68, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %rax
               	leaq	-0x38(%rbp), %rsi
               	movslq	0x4(%rsi), %rsi
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	$0x21, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %rax
               	leaq	-0x48(%rbp), %rsi
               	movslq	0x4(%rsi), %rsi
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	leaq	-0x48(%rbp), %rsi
               	movslq	0x8(%rsi), %rsi
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x499602d2, %rdx       # imm = 0x499602D2
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x41, %rcx
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
