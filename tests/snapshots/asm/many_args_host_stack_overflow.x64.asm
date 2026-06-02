
many_args_host_stack_overflow.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	popq	%r10
               	subq	$0x50, %rsp
               	movq	0x50(%rsp), %rax
               	movq	%rax, (%rsp)
               	movq	0x58(%rsp), %rax
               	movq	%rax, 0x10(%rsp)
               	movq	0x60(%rsp), %rax
               	movq	%rax, 0x20(%rsp)
               	movq	0x68(%rsp), %rax
               	movq	%rax, 0x30(%rsp)
               	movq	0x70(%rsp), %rax
               	movq	%rax, 0x40(%rsp)
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movslq	%ecx, %rcx
               	movslq	%r8d, %r8
               	movslq	%r9d, %r9
               	cmpq	$0x1, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	cmpq	$0x2, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	cmpq	$0x3, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	cmpq	$0x4, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	cmpq	$0x5, %r8
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	cmpq	$0x6, %r9
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	movslq	0x70(%rbp), %r9
               	cmpq	$0x7, %r9
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	movslq	0x80(%rbp), %r9
               	cmpq	$0x8, %r9
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	movslq	0x90(%rbp), %r9
               	cmpq	$0x9, %r9
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	movslq	0xa0(%rbp), %r9
               	cmpq	$0xa, %r9
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	movslq	0xb0(%rbp), %r9
               	cmpq	$0xb, %r9
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r12, (%rsp)
               	movq	%r14, 0x8(%rsp)
               	movq	%r15, 0x10(%rsp)
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movl	$0x7, %r11d
               	movl	$0x8, %eax
               	movl	$0x9, %r15d
               	movl	$0xa, %r14d
               	movl	$0xb, %r12d
               	subq	$0x30, %rsp
               	movq	%r11, (%rsp)
               	movq	%rax, 0x8(%rsp)
               	movq	%r15, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r12, 0x20(%rsp)
               	callq	<addr>
               	addq	$0x30, %rsp
               	movq	%rax, %rcx
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r14
               	movq	0x10(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
