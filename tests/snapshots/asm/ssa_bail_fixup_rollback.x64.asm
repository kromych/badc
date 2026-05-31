
ssa_bail_fixup_rollback.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %r11
               	movq	%r11, %r9
               	addq	$0x3, %r9
               	movzbq	(%r9), %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	shlq	$0x8, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	movq	%r11, %r9
               	addq	$0x2, %r9
               	movzbq	(%r9), %rdi
               	orq	%rdi, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	shlq	$0x8, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	movq	%r11, %rdi
               	addq	$0x1, %rdi
               	movzbq	(%rdi), %r9
               	orq	%r9, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	shlq	$0x8, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	movzbq	(%r11), %r9
               	movq	%r8, %rax
               	orq	%r9, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%r15, (%rsp)
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movq	%rdx, %r8
               	movq	%rcx, %rdi
               	xorq	%rsi, %rsi
               	movl	%esi, -0x48(%rbp)
               	jmp	<addr>
               	movslq	-0x48(%rbp), %rsi
               	cmpq	$0x4, %rsi
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x48(%rbp), %rdx
               	movslq	(%rdx), %rsi
               	addq	$0x1, %rsi
               	movl	%esi, (%rdx)
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rsi
               	movslq	-0x48(%rbp), %rcx
               	movl	$0x5, %edx
               	imulq	%rcx, %rdx
               	movslq	%edx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	shlq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	addq	%rdi, %rcx
               	movq	%rcx, %rdx
               	addq	$0x3, %rdx
               	movzbq	(%rdx), %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	shlq	$0x8, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	movq	%rcx, %rdx
               	addq	$0x2, %rdx
               	movzbq	(%rdx), %r15
               	orq	%r15, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	shlq	$0x8, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	movq	%rcx, %r15
               	addq	$0x1, %r15
               	movzbq	(%r15), %rdx
               	orq	%rdx, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	shlq	$0x8, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	movzbq	(%rcx), %rdx
               	orq	%rdx, %rax
               	movl	%eax, (%rsi)
               	leaq	-0x40(%rbp), %rdx
               	movslq	-0x48(%rbp), %rax
               	movq	%rax, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	addq	%r8, %rax
               	movq	%rax, %rsi
               	addq	$0x3, %rsi
               	movzbq	(%rsi), %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	shlq	$0x8, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	movq	%rax, %rsi
               	addq	$0x2, %rsi
               	movzbq	(%rsi), %r15
               	orq	%r15, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	shlq	$0x8, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	movq	%rax, %r15
               	addq	$0x1, %r15
               	movzbq	(%r15), %rsi
               	orq	%rsi, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	shlq	$0x8, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	movzbq	(%rax), %rsi
               	orq	%rsi, %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0x40(%rbp), %rsi
               	movslq	-0x48(%rbp), %rcx
               	movq	%rcx, %rdx
               	addq	$0x6, %rdx
               	movslq	%edx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	shlq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	addq	%r9, %rcx
               	movq	%rcx, %rdx
               	addq	$0x3, %rdx
               	movzbq	(%rdx), %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	shlq	$0x8, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	movq	%rcx, %rdx
               	addq	$0x2, %rdx
               	movzbq	(%rdx), %r15
               	orq	%r15, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	shlq	$0x8, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	movq	%rcx, %r15
               	addq	$0x1, %r15
               	movzbq	(%r15), %rdx
               	orq	%rdx, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	shlq	$0x8, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	movzbq	(%rcx), %rdx
               	orq	%rdx, %rax
               	movl	%eax, (%rsi)
               	leaq	-0x40(%rbp), %rdx
               	movslq	-0x48(%rbp), %rax
               	movq	%rax, %rsi
               	addq	$0xb, %rsi
               	movslq	%esi, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	movq	%r8, %rsi
               	addq	$0x10, %rsi
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rsi
               	movq	%rsi, %rax
               	addq	$0x3, %rax
               	movzbq	(%rax), %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	shlq	$0x8, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	movq	%rsi, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %r15
               	orq	%r15, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	shlq	$0x8, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	movq	%rsi, %r15
               	addq	$0x1, %r15
               	movzbq	(%r15), %rax
               	orq	%rax, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	shlq	$0x8, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	movzbq	(%rsi), %rax
               	orq	%rax, %rcx
               	movl	%ecx, (%rdx)
               	jmp	<addr>
               	xorq	%rax, %rax
               	leaq	-0x40(%rbp), %rcx
               	movl	(%rcx), %edi
               	leaq	-0x40(%rbp), %rcx
               	addq	$0x14, %rcx
               	movl	(%rcx), %r8d
               	xorq	%r8, %rdi
               	leaq	-0x40(%rbp), %r8
               	addq	$0x28, %r8
               	movl	(%r8), %ecx
               	xorq	%rcx, %rdi
               	leaq	-0x40(%rbp), %rcx
               	addq	$0x3c, %rcx
               	movl	(%rcx), %r8d
               	xorq	%r8, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r11)
               	movq	%rax, %rcx
               	movq	(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
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
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, 0x10(%rbp)
               	movq	%rsi, 0x20(%rbp)
               	movq	%rdx, 0x30(%rbp)
               	movq	%r8, %rbx
               	movq	0x30(%rbp), %r8
               	cmpq	$0x0, %r8
               	jne	<addr>
               	xorq	%r11, %r11
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x50, %rsp
               	pushq	%r11
               	retq
               	xorq	%r8, %r8
               	movl	%r8d, -0x58(%rbp)
               	jmp	<addr>
               	movl	-0x58(%rbp), %r8d
               	cmpq	$0x10, %r8
               	jae	<addr>
               	jmp	<addr>
               	leaq	-0x58(%rbp), %r11
               	movl	(%r11), %r8d
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %r8
               	movl	-0x58(%rbp), %r9d
               	addq	%r9, %r8
               	xorq	%r9, %r9
               	movb	%r9b, (%r8)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x58(%rbp)
               	jmp	<addr>
               	movl	-0x58(%rbp), %r9d
               	cmpq	$0x8, %r9
               	jae	<addr>
               	jmp	<addr>
               	leaq	-0x58(%rbp), %r11
               	movl	(%r11), %r9d
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %r9
               	movl	-0x58(%rbp), %r8d
               	addq	%r8, %r9
               	addq	%rcx, %r8
               	movzbq	(%r8), %r11
               	movb	%r11b, (%r9)
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x30(%rbp), %r11
               	cmpq	$0x40, %r11
               	jb	<addr>
               	leaq	-0x50(%rbp), %r12
               	leaq	-0x10(%rbp), %r14
               	leaq	<rip>, %r15
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	callq	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x58(%rbp)
               	jmp	<addr>
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x50, %rsp
               	pushq	%r11
               	retq
               	movl	-0x58(%rbp), %eax
               	cmpq	$0x40, %rax
               	jae	<addr>
               	jmp	<addr>
               	leaq	-0x58(%rbp), %r15
               	movl	(%r15), %eax
               	addq	$0x1, %rax
               	movl	%eax, (%r15)
               	jmp	<addr>
               	movq	0x10(%rbp), %rax
               	movl	-0x58(%rbp), %r14d
               	addq	%r14, %rax
               	movq	0x20(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	jmp	<addr>
               	leaq	0x30(%rbp), %r14
               	movq	(%r14), %r12
               	subq	$0x40, %r12
               	movq	%r12, (%r14)
               	leaq	0x10(%rbp), %rax
               	movq	(%rax), %r12
               	addq	$0x40, %r12
               	movq	%r12, (%rax)
               	movq	0x20(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	jmp	<addr>
               	movq	0x20(%rbp), %r15
               	movl	-0x58(%rbp), %r14d
               	addq	%r14, %r15
               	movzbq	(%r15), %r14
               	movq	%r14, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%r14, %r14
               	movq	%r14, -0x80(%rbp)
               	jmp	<addr>
               	movq	-0x80(%rbp), %r14
               	leaq	-0x50(%rbp), %r15
               	movl	-0x58(%rbp), %r12d
               	addq	%r12, %r15
               	movzbq	(%r15), %r12
               	xorq	%r12, %r14
               	movb	%r14b, (%rax)
               	jmp	<addr>
               	leaq	0x20(%rbp), %r12
               	movq	(%r12), %r14
               	addq	$0x40, %r14
               	movq	%r14, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x48(%rbp), %r11
               	leaq	<rip>, %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	popq	%rax
               	movq	%r11, %r8
               	xorq	%r8, %r8
               	movl	%r8d, -0x70(%rbp)
               	jmp	<addr>
               	movslq	-0x70(%rbp), %r8
               	cmpq	$0x20, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r9
               	movslq	(%r9), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r9)
               	jmp	<addr>
               	leaq	-0x68(%rbp), %r8
               	movslq	-0x70(%rbp), %r11
               	addq	%r11, %r8
               	andq	$0xff, %r11
               	movb	%r11b, (%r8)
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rbx
               	xorq	%r12, %r12
               	movl	$0x40, %r14d
               	leaq	-0x48(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	-0x68(%rbp), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %r8
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movq	0x28(%rsp), %rcx
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	movzbq	(%rax), %r15
               	xorq	$0x4d, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0xa0(%rbp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0xa0(%rbp)
               	jmp	<addr>
               	movq	-0xa0(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
