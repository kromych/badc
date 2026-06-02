
macro_operators.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%rdi, %rdi
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %r8
               	movq	(%rax), %rax
               	movq	%rax, (%r8)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	addq	%rsi, %rdi
               	movslq	%edi, %rdi
               	addq	%rdx, %rdi
               	movslq	%edi, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	<rip>, %r11
               	movzbq	(%r11), %r9
               	xorq	$0x68, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x1, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r9
               	addq	$0x1, %r9
               	movzbq	(%r9), %r9
               	xorq	$0x65, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x2, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r9
               	addq	$0x2, %r9
               	movzbq	(%r9), %r9
               	xorq	$0x6c, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r9
               	addq	$0x3, %r9
               	movzbq	(%r9), %r9
               	xorq	$0x6c, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x4, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r9
               	addq	$0x4, %r9
               	movzbq	(%r9), %r9
               	xorq	$0x6f, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x5, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addq	$0x5, %r11
               	movzbq	(%r11), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x6, %r9d
               	movq	%r9, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %r11d
               	cmpq	$0x2a, %r11
               	je	<addr>
               	movl	$0x7, %r9d
               	movq	%r9, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %r11d
               	movl	$0x2, %r9d
               	movl	$0x3, %r8d
               	addq	%r9, %r11
               	movslq	%r11d, %r11
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x6, %r11
               	je	<addr>
               	movl	$0x8, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x7, %esi
               	movl	$0x8, %edx
               	movl	$0x9, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
