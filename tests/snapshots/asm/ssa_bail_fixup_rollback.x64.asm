
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
               	movzbq	(%r9), %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	movq	%r11, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %r8
               	orq	%r8, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	orq	%r8, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	shlq	$0x8, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	movzbq	(%r11), %r11
               	movq	%r9, %rax
               	orq	%r11, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
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
               	movzbq	(%rdx), %rdx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rdx
               	shlq	$0x8, %rdx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rdx
               	movq	%rcx, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	orq	%rax, %rdx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rdx
               	shlq	$0x8, %rdx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rdx
               	movq	%rcx, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %rax
               	orq	%rax, %rdx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rdx
               	shlq	$0x8, %rdx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rdx
               	movzbq	(%rcx), %rcx
               	orq	%rcx, %rdx
               	movl	%edx, (%rsi)
               	leaq	-0x40(%rbp), %rcx
               	movslq	-0x48(%rbp), %rdx
               	movq	%rdx, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rcx
               	shlq	$0x2, %rdx
               	movslq	%edx, %rdx
               	addq	%r8, %rdx
               	movq	%rdx, %rsi
               	addq	$0x3, %rsi
               	movzbq	(%rsi), %rsi
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rsi
               	shlq	$0x8, %rsi
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rsi
               	movq	%rdx, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	orq	%rax, %rsi
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rsi
               	shlq	$0x8, %rsi
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rsi
               	movq	%rdx, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %rax
               	orq	%rax, %rsi
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rsi
               	shlq	$0x8, %rsi
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rsi
               	movzbq	(%rdx), %rdx
               	orq	%rdx, %rsi
               	movl	%esi, (%rcx)
               	leaq	-0x40(%rbp), %rdx
               	movslq	-0x48(%rbp), %rsi
               	movq	%rsi, %rcx
               	addq	$0x6, %rcx
               	movslq	%ecx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	shlq	$0x2, %rsi
               	movslq	%esi, %rsi
               	addq	%r9, %rsi
               	movq	%rsi, %rcx
               	addq	$0x3, %rcx
               	movzbq	(%rcx), %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	shlq	$0x8, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	movq	%rsi, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	orq	%rax, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	shlq	$0x8, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	movq	%rsi, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %rax
               	orq	%rax, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	shlq	$0x8, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	movzbq	(%rsi), %rsi
               	orq	%rsi, %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0x40(%rbp), %rsi
               	movslq	-0x48(%rbp), %rcx
               	movq	%rcx, %rdx
               	addq	$0xb, %rdx
               	movslq	%edx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movq	%r8, %rdx
               	addq	$0x10, %rdx
               	shlq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	movq	%rdx, %rcx
               	addq	$0x3, %rcx
               	movzbq	(%rcx), %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	shlq	$0x8, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	movq	%rdx, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	orq	%rax, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	shlq	$0x8, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	movq	%rdx, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %rax
               	orq	%rax, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	shlq	$0x8, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	movzbq	(%rdx), %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rsi)
               	jmp	<addr>
               	xorq	%rax, %rax
               	leaq	-0x40(%rbp), %rdx
               	movl	(%rdx), %edx
               	leaq	-0x40(%rbp), %rdi
               	addq	$0x14, %rdi
               	movl	(%rdi), %edi
               	xorq	%rdi, %rdx
               	leaq	-0x40(%rbp), %rdi
               	addq	$0x28, %rdi
               	movl	(%rdi), %edi
               	xorq	%rdi, %rdx
               	leaq	-0x40(%rbp), %rdi
               	addq	$0x3c, %rdi
               	movl	(%rdi), %edi
               	xorq	%rdi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r11)
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
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
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
               	leaq	-0x58(%rbp), %rsi
               	movl	(%rsi), %eax
               	addq	$0x1, %rax
               	movl	%eax, (%rsi)
               	jmp	<addr>
               	movq	0x10(%rbp), %rax
               	movl	-0x58(%rbp), %edi
               	addq	%rdi, %rax
               	movq	0x20(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	jmp	<addr>
               	leaq	0x30(%rbp), %rsi
               	movq	(%rsi), %rdi
               	subq	$0x40, %rdi
               	movq	%rdi, (%rsi)
               	leaq	0x10(%rbp), %rax
               	movq	(%rax), %rdi
               	addq	$0x40, %rdi
               	movq	%rdi, (%rax)
               	movq	0x20(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	jmp	<addr>
               	movq	0x20(%rbp), %rsi
               	movl	-0x58(%rbp), %edi
               	addq	%rdi, %rsi
               	movzbq	(%rsi), %rsi
               	movq	%rsi, -0x80(%rbp)
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	movq	%rsi, -0x80(%rbp)
               	jmp	<addr>
               	movq	-0x80(%rbp), %rsi
               	leaq	-0x50(%rbp), %rdi
               	movl	-0x58(%rbp), %r9d
               	addq	%r9, %rdi
               	movzbq	(%rdi), %rdi
               	xorq	%rdi, %rsi
               	movb	%sil, (%rax)
               	jmp	<addr>
               	leaq	0x20(%rbp), %rdi
               	movq	(%rdi), %rsi
               	addq	$0x40, %rsi
               	movq	%rsi, (%rdi)
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
               	xorq	%rcx, %rcx
               	movq	%rcx, -0xa0(%rbp)
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, -0xa0(%rbp)
               	jmp	<addr>
               	movq	-0xa0(%rbp), %rcx
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
