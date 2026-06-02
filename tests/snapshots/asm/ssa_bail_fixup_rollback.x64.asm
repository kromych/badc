
ssa_bail_fixup_rollback.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %r9
               	addq	$0x3, %r9
               	movzbq	(%r9), %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movq	%rdi, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %r8
               	orq	%r8, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movq	%rdi, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	orq	%r8, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movzbq	(%rdi), %rdi
               	movq	%r9, %rax
               	orq	%rdi, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	xorq	%r9, %r9
               	movl	%r9d, -0x48(%rbp)
               	jmp	<addr>
               	movslq	-0x48(%rbp), %r9
               	cmpq	$0x4, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x48(%rbp), %r8
               	movslq	(%r8), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r8)
               	jmp	<addr>
               	leaq	-0x40(%rbp), %r9
               	movslq	-0x48(%rbp), %r11
               	movl	$0x5, %r8d
               	imulq	%r11, %r8
               	movslq	%r8d, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %r9
               	shlq	$0x2, %r11
               	movslq	%r11d, %r11
               	addq	%rcx, %r11
               	movq	%r11, %r8
               	addq	$0x3, %r8
               	movzbq	(%r8), %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	shlq	$0x8, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	movq	%r11, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	orq	%rax, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	shlq	$0x8, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	movq	%r11, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %rax
               	orq	%rax, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	shlq	$0x8, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	movzbq	(%r11), %r11
               	orq	%r11, %r8
               	movl	%r8d, (%r9)
               	leaq	-0x40(%rbp), %r11
               	movslq	-0x48(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %r11
               	shlq	$0x2, %r8
               	movslq	%r8d, %r8
               	addq	%rdx, %r8
               	movq	%r8, %r9
               	addq	$0x3, %r9
               	movzbq	(%r9), %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	movq	%r8, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	orq	%rax, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	movq	%r8, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %rax
               	orq	%rax, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	movzbq	(%r8), %r8
               	orq	%r8, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x40(%rbp), %r8
               	movslq	-0x48(%rbp), %r9
               	movq	%r9, %r11
               	addq	$0x6, %r11
               	movslq	%r11d, %r11
               	shlq	$0x2, %r11
               	addq	%r11, %r8
               	shlq	$0x2, %r9
               	movslq	%r9d, %r9
               	addq	%rsi, %r9
               	movq	%r9, %r11
               	addq	$0x3, %r11
               	movzbq	(%r11), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	shlq	$0x8, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movq	%r9, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	orq	%rax, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	shlq	$0x8, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movq	%r9, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %rax
               	orq	%rax, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	shlq	$0x8, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movzbq	(%r9), %r9
               	orq	%r9, %r11
               	movl	%r11d, (%r8)
               	leaq	-0x40(%rbp), %r9
               	movslq	-0x48(%rbp), %r11
               	movq	%r11, %r8
               	addq	$0xb, %r8
               	movslq	%r8d, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %r9
               	movq	%rdx, %r8
               	addq	$0x10, %r8
               	shlq	$0x2, %r11
               	movslq	%r11d, %r11
               	addq	%r11, %r8
               	movq	%r8, %r11
               	addq	$0x3, %r11
               	movzbq	(%r11), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	shlq	$0x8, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movq	%r8, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	orq	%rax, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	shlq	$0x8, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movq	%r8, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %rax
               	orq	%rax, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	shlq	$0x8, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movzbq	(%r8), %r8
               	orq	%r8, %r11
               	movl	%r11d, (%r9)
               	jmp	<addr>
               	xorq	%rax, %rax
               	leaq	-0x40(%rbp), %r8
               	movl	(%r8), %r8d
               	leaq	-0x40(%rbp), %rcx
               	addq	$0x14, %rcx
               	movl	(%rcx), %ecx
               	xorq	%rcx, %r8
               	leaq	-0x40(%rbp), %rcx
               	addq	$0x28, %rcx
               	movl	(%rcx), %ecx
               	xorq	%rcx, %r8
               	leaq	-0x40(%rbp), %rcx
               	addq	$0x3c, %rcx
               	movl	(%rcx), %ecx
               	xorq	%rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
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
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
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
               	movzbq	(%r8), %r8
               	movb	%r8b, (%r9)
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x30(%rbp), %r8
               	cmpq	$0x40, %r8
               	jb	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x10(%rbp), %rsi
               	leaq	<rip>, %rcx
               	movq	%rbx, %rdx
               	callq	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x58(%rbp)
               	jmp	<addr>
               	xorq	%rcx, %rcx
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
               	leaq	-0x58(%rbp), %rcx
               	movl	(%rcx), %eax
               	addq	$0x1, %rax
               	movl	%eax, (%rcx)
               	jmp	<addr>
               	movq	0x10(%rbp), %rax
               	movl	-0x58(%rbp), %esi
               	addq	%rsi, %rax
               	movq	0x20(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	jmp	<addr>
               	leaq	0x30(%rbp), %rcx
               	movq	(%rcx), %rsi
               	subq	$0x40, %rsi
               	movq	%rsi, (%rcx)
               	leaq	0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	addq	$0x40, %rsi
               	movq	%rsi, (%rax)
               	movq	0x20(%rbp), %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	movq	0x20(%rbp), %rcx
               	movl	-0x58(%rbp), %esi
               	addq	%rsi, %rcx
               	movzbq	(%rcx), %rcx
               	movq	%rcx, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x80(%rbp)
               	jmp	<addr>
               	movq	-0x80(%rbp), %rcx
               	leaq	-0x50(%rbp), %rsi
               	movl	-0x58(%rbp), %edi
               	addq	%rdi, %rsi
               	movzbq	(%rsi), %rsi
               	xorq	%rsi, %rcx
               	movb	%cl, (%rax)
               	jmp	<addr>
               	leaq	0x20(%rbp), %rsi
               	movq	(%rsi), %rcx
               	addq	$0x40, %rcx
               	movq	%rcx, (%rsi)
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	leaq	-0x48(%rbp), %r11
               	leaq	<rip>, %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	popq	%rax
               	xorq	%r11, %r11
               	movl	%r11d, -0x70(%rbp)
               	jmp	<addr>
               	movslq	-0x70(%rbp), %r11
               	cmpq	$0x20, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	<addr>
               	leaq	-0x68(%rbp), %r11
               	movslq	-0x70(%rbp), %r8
               	addq	%r8, %r11
               	andq	$0xff, %r8
               	movb	%r8b, (%r11)
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
               	xorq	%r8, %r8
               	movq	%r8, -0xa0(%rbp)
               	jmp	<addr>
               	movl	$0x1, %r8d
               	movq	%r8, -0xa0(%rbp)
               	jmp	<addr>
               	movq	-0xa0(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
