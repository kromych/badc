
mul_pow2_to_shift.x64:	file format elf64-x86-64

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
               	movq	%r12, 0x8(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r12, %r8
               	movq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%r12, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x8, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x10, %r8
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%r12, %rsi
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r14, 0x8(%rsp)
               	movq	%r15, 0x10(%rsp)
               	movl	$0x7, %r11d
               	movq	%r11, %r9
               	shlq	$0x1, %r9
               	movslq	%r9d, %r9
               	movq	%r11, %r8
               	shlq	$0x2, %r8
               	movslq	%r8d, %r8
               	movq	%r11, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	movq	%r11, %rsi
               	shlq	$0x4, %rsi
               	movslq	%esi, %rsi
               	movq	%r11, %rdx
               	shlq	$0xa, %rdx
               	movslq	%edx, %rdx
               	movq	%r11, %rcx
               	shlq	$0x1, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	movq	%r11, %rax
               	shlq	$0x8, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	movq	%r11, %r15
               	shlq	$0x5, %r15
               	shlq	$0x10, %r11
               	movslq	%r9d, %r9
               	movslq	%r8d, %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movslq	%edi, %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	movslq	%esi, %rsi
               	addq	%rsi, %r9
               	movslq	%r9d, %r9
               	movslq	%edx, %rdx
               	addq	%rdx, %r9
               	movslq	%r9d, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	addq	%rcx, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	addq	%rax, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	addq	%r15, %r9
               	movq	%r9, %rbx
               	addq	%r11, %rbx
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x724c0, %rbx          # imm = 0x724C0
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x88(%rbp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x88(%rbp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r14
               	movq	0x10(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
