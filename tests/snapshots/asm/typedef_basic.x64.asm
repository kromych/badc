
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
               	movl	$0x64, %r11d
               	movl	$0x41, %r9d
               	movl	$0x499602d2, %r8d       # imm = 0x499602D2
               	leaq	<rip>, %rdi
               	leaq	-0x30(%rbp), %rsi
               	movl	$0x7, %edx
               	movl	%edx, (%rsi)
               	leaq	-0x30(%rbp), %rcx
               	addq	$0x8, %rcx
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rcx)
               	leaq	-0x38(%rbp), %rsi
               	movl	$0xb, %edx
               	movl	%edx, (%rsi)
               	leaq	-0x38(%rbp), %rcx
               	addq	$0x4, %rcx
               	movl	$0x16, %edx
               	movl	%edx, (%rcx)
               	leaq	-0x48(%rbp), %rsi
               	movl	$0x1, %edx
               	movl	%edx, (%rsi)
               	leaq	-0x48(%rbp), %rcx
               	addq	$0x4, %rcx
               	movl	$0x2, %edx
               	movl	%edx, (%rcx)
               	leaq	-0x48(%rbp), %rsi
               	addq	$0x8, %rsi
               	movl	$0x3, %edx
               	movl	%edx, (%rsi)
               	addq	%r9, %r11
               	movslq	%r11d, %r11
               	cmpq	$0xa5, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rdi), %rdi
               	xorq	$0x68, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0x7, %rdi
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rdi
               	movslq	(%rdi), %rdi
               	leaq	-0x38(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	cmpq	$0x21, %rdi
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rdi
               	movslq	(%rdi), %rdi
               	leaq	-0x48(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	leaq	-0x48(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	cmpq	$0x6, %rdi
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x499602d2, %r8        # imm = 0x499602D2
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x41, %r9
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
