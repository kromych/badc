
ssa_bail_fixup_rollback.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	movq	%rax, %rcx
               	addq	$0x3, %rcx
               	movzbq	(%rcx), %rcx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rcx
               	shlq	$0x8, %rcx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rcx
               	movq	%rax, %rdx
               	addq	$0x2, %rdx
               	movzbq	(%rdx), %rdx
               	orq	%rdx, %rcx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rcx
               	shlq	$0x8, %rcx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rcx
               	movq	%rax, %rdx
               	addq	$0x1, %rdx
               	movzbq	(%rdx), %rdx
               	orq	%rdx, %rcx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rcx
               	shlq	$0x8, %rcx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rcx
               	movzbq	(%rax), %rax
               	orq	%rcx, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, %rax
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
               	movq	%r10, %rsi
               	xorq	%rdi, %rdi
               	movl	%edi, -0x48(%rbp)
               	jmp	<addr>
               	movslq	-0x48(%rbp), %rdi
               	cmpq	$0x4, %rdi
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x48(%rbp), %rdi
               	movslq	(%rdi), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rdi)
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movslq	-0x48(%rbp), %r8
               	imulq	$0x5, %r8, %r9
               	movslq	%r9d, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rdi
               	shlq	$0x2, %r8
               	movslq	%r8d, %r8
               	addq	%rsi, %r8
               	movq	%r8, %r9
               	addq	$0x3, %r9
               	movzbq	(%r9), %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movq	%r8, %r11
               	addq	$0x2, %r11
               	movzbq	(%r11), %r11
               	orq	%r11, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movq	%r8, %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %r11
               	orq	%r11, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movzbq	(%r8), %r8
               	orq	%r9, %r8
               	movl	%r8d, (%rdi)
               	leaq	-0x40(%rbp), %rdi
               	movslq	-0x48(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rdi
               	shlq	$0x2, %r8
               	movslq	%r8d, %r8
               	addq	%rdx, %r8
               	movq	%r8, %r9
               	addq	$0x3, %r9
               	movzbq	(%r9), %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movq	%r8, %r11
               	addq	$0x2, %r11
               	movzbq	(%r11), %r11
               	orq	%r11, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movq	%r8, %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %r11
               	orq	%r11, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movzbq	(%r8), %r8
               	orq	%r9, %r8
               	movl	%r8d, (%rdi)
               	leaq	-0x40(%rbp), %rdi
               	movslq	-0x48(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x6, %r9
               	movslq	%r9d, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rdi
               	shlq	$0x2, %r8
               	movslq	%r8d, %r8
               	addq	%rcx, %r8
               	movq	%r8, %r9
               	addq	$0x3, %r9
               	movzbq	(%r9), %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movq	%r8, %r11
               	addq	$0x2, %r11
               	movzbq	(%r11), %r11
               	orq	%r11, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movq	%r8, %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %r11
               	orq	%r11, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movzbq	(%r8), %r8
               	orq	%r9, %r8
               	movl	%r8d, (%rdi)
               	leaq	-0x40(%rbp), %rdi
               	movslq	-0x48(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0xb, %r9
               	movslq	%r9d, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rdi
               	movq	%rdx, %r9
               	addq	$0x10, %r9
               	shlq	$0x2, %r8
               	movslq	%r8d, %r8
               	addq	%r9, %r8
               	movq	%r8, %r9
               	addq	$0x3, %r9
               	movzbq	(%r9), %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movq	%r8, %r11
               	addq	$0x2, %r11
               	movzbq	(%r11), %r11
               	orq	%r11, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movq	%r8, %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %r11
               	orq	%r11, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movzbq	(%r8), %r8
               	orq	%r9, %r8
               	movl	%r8d, (%rdi)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	leaq	-0x40(%rbp), %rdx
               	movl	(%rdx), %edx
               	leaq	-0x40(%rbp), %rsi
               	addq	$0x14, %rsi
               	movl	(%rsi), %esi
               	xorq	%rsi, %rdx
               	leaq	-0x40(%rbp), %rsi
               	addq	$0x28, %rsi
               	movl	(%rsi), %esi
               	xorq	%rsi, %rdx
               	leaq	-0x40(%rbp), %rsi
               	addq	$0x3c, %rsi
               	movl	(%rsi), %esi
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rax)
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r8, %rbx
               	movq	%rdi, 0x10(%rbp)
               	movq	%rsi, 0x20(%rbp)
               	movq	%rdx, 0x30(%rbp)
               	movq	0x30(%rbp), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x50, %rsp
               	pushq	%r11
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x58(%rbp)
               	jmp	<addr>
               	movl	-0x58(%rbp), %eax
               	cmpq	$0x10, %rax
               	jae	<addr>
               	jmp	<addr>
               	leaq	-0x58(%rbp), %rax
               	movl	(%rax), %edx
               	addq	$0x1, %rdx
               	movl	%edx, (%rax)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movl	-0x58(%rbp), %edx
               	addq	%rdx, %rax
               	xorq	%rdx, %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x58(%rbp)
               	jmp	<addr>
               	movl	-0x58(%rbp), %eax
               	cmpq	$0x8, %rax
               	jae	<addr>
               	jmp	<addr>
               	leaq	-0x58(%rbp), %rax
               	movl	(%rax), %edx
               	addq	$0x1, %rdx
               	movl	%edx, (%rax)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movl	-0x58(%rbp), %edx
               	addq	%rdx, %rax
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x30(%rbp), %rax
               	cmpq	$0x40, %rax
               	jb	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x10(%rbp), %rsi
               	leaq	<rip>, %rcx
               	movq	%rbx, %rdx
               	callq	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x58(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x50, %rsp
               	pushq	%r11
               	retq
               	movl	-0x58(%rbp), %eax
               	cmpq	$0x40, %rax
               	jae	<addr>
               	jmp	<addr>
               	leaq	-0x58(%rbp), %rax
               	movl	(%rax), %ecx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	movq	0x10(%rbp), %rax
               	movl	-0x58(%rbp), %ecx
               	addq	%rcx, %rax
               	movq	0x20(%rbp), %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	0x30(%rbp), %rax
               	movq	(%rax), %rcx
               	subq	$0x40, %rcx
               	movq	%rcx, (%rax)
               	leaq	0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$0x40, %rcx
               	movq	%rcx, (%rax)
               	movq	0x20(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movq	0x20(%rbp), %rcx
               	movl	-0x58(%rbp), %edx
               	addq	%rdx, %rcx
               	movzbq	(%rcx), %rdx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movl	-0x58(%rbp), %esi
               	addq	%rsi, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	%rdx, %rcx
               	movb	%cl, (%rax)
               	jmp	<addr>
               	leaq	0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$0x40, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	xorq	%rax, %rax
               	movl	%eax, -0x70(%rbp)
               	jmp	<addr>
               	movslq	-0x70(%rbp), %rax
               	cmpq	$0x20, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	-0x70(%rbp), %rcx
               	addq	%rcx, %rax
               	andq	$0xff, %rcx
               	movb	%cl, (%rax)
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x40, %edx
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x68(%rbp), %r8
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x4d, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
