
deferred_libc_vfprintf_va_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	movslq	%edx, %r8
               	movl	%r8d, 0x30(%rbp)
               	movslq	%ecx, %rdi
               	movl	%r9d, -0x8(%rbp)
               	movslq	-0x8(%rbp), %r8
               	addq	%r11, %r8
               	xorq	%r9, %r9
               	movb	%r9b, (%r8)
               	movslq	0x30(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	movslq	-0x8(%rbp), %r9
               	subq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rsi
               	addq	%r11, %rsi
               	movl	$0x30, %r9d
               	movb	%r9b, (%rsi)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>
               	movslq	0x30(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	cmpq	$0xa, %rdi
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	movslq	0x30(%rbp), %r9
               	movl	$0xa, %eax
               	movq	%rax, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, -0x10(%rbp)
               	movq	%rax, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movl	%r9d, 0x30(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r9
               	subq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rdx
               	cmpq	$0xa, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	0x30(%rbp), %r9
               	movq	%r9, %rax
               	andq	$0xf, %rax
               	movl	%eax, -0x10(%rbp)
               	sarq	$0x4, %r9
               	movabsq	$0xfffffffffffffff, %r10 # imm = 0xFFFFFFFFFFFFFFF
               	andq	%r10, %r9
               	movl	%r9d, 0x30(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r9
               	addq	%r11, %r9
               	movslq	-0x10(%rbp), %rdx
               	addq	$0x30, %rdx
               	movslq	%edx, %rdx
               	movb	%dl, (%r9)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	addq	%r11, %rdx
               	movslq	-0x10(%rbp), %rax
               	addq	$0x61, %rax
               	movslq	%eax, %rax
               	subq	$0xa, %rax
               	movslq	%eax, %rax
               	movb	%al, (%rdx)
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	movq	%rdx, %r8
               	movslq	%ecx, %rdi
               	cmpq	$0x0, %r9
               	setg	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x8(%rbp)
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movslq	(%r8), %rdx
               	addq	$0x1, %rdx
               	movslq	%edx, %rdx
               	cmpq	%r9, %rdx
               	setl	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0x8(%rbp)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movslq	(%r8), %r9
               	addq	%r9, %r11
               	andq	$0xff, %rdi
               	movb	%dil, (%r11)
               	jmp	<addr>
               	movslq	(%r8), %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, (%r8)
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rcx, (%rsp)
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x210, %rsp            # imm = 0x210
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %r10
               	movq	%r10, 0x38(%rsp)
               	movslq	%esi, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	%rdx, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%rcx, %rdi
               	movq	%rdi, 0x40(%rbp)
               	xorq	%rsi, %rsi
               	movl	%esi, -0x8(%rbp)
               	movl	%esi, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rsi
               	movq	0x28(%rsp), %rsi
               	addq	%rsi, %rsi
               	movzbq	(%rsi), %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movslq	-0x10(%rbp), %rsi
               	movq	0x28(%rsp), %rsi
               	addq	%rsi, %rsi
               	movzbq	(%rsi), %rdi
               	movb	%dil, -0x70(%rbp)
               	movzbq	-0x70(%rbp), %rsi
               	xorq	$0x25, %rsi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	jmp	<addr>
               	movq	0x30(%rsp), %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r15
               	movzbq	-0x70(%rbp), %rbx
               	movq	%r15, %rdx
               	movq	%rbx, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x50(%rbp)
               	movl	%ebx, -0x58(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rbx
               	movq	0x28(%rsp), %rbx
               	addq	%rbx, %rbx
               	movzbq	(%rbx), %rax
               	xorq	$0x2d, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x110(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rbx
               	movq	0x28(%rsp), %rbx
               	addq	%rbx, %rbx
               	movzbq	(%rbx), %rax
               	xorq	$0x2d, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x38(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movq	0x28(%rsp), %rax
               	addq	%rax, %rax
               	movzbq	(%rax), %rbx
               	xorq	$0x2a, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rbx
               	movq	0x28(%rsp), %rbx
               	addq	%rbx, %rbx
               	movzbq	(%rbx), %rax
               	xorq	$0x30, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x110(%rbp)
               	jmp	<addr>
               	movq	-0x110(%rbp), %rax
               	movq	%rax, -0x108(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rbx
               	movq	0x28(%rsp), %rbx
               	addq	%rbx, %rbx
               	movzbq	(%rbx), %rax
               	xorq	$0x2b, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x108(%rbp)
               	jmp	<addr>
               	movq	-0x108(%rbp), %rax
               	movq	%rax, -0x100(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rbx
               	movq	0x28(%rsp), %rbx
               	addq	%rbx, %rbx
               	movzbq	(%rbx), %rax
               	xorq	$0x20, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x100(%rbp)
               	jmp	<addr>
               	movq	-0x100(%rbp), %rax
               	movq	%rax, -0xf8(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rbx
               	movq	0x28(%rsp), %rbx
               	addq	%rbx, %rbx
               	movzbq	(%rbx), %rax
               	xorq	$0x23, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xf8(%rbp)
               	jmp	<addr>
               	movq	-0xf8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %ebx
               	movl	%ebx, -0x50(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rbx
               	addq	$0x1, %rbx
               	movslq	%ebx, %rbx
               	movl	%ebx, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rbx
               	movq	0x28(%rsp), %rbx
               	addq	%rbx, %rbx
               	movzbq	(%rbx), %rax
               	xorq	$0x30, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x1, %ebx
               	movl	%ebx, -0x58(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x40(%rbp), %rax
               	movq	(%rax), %rbx
               	leaq	0x10(%rbx), %r11
               	movq	%r11, (%rax)
               	movslq	(%rbx), %rax
               	movl	%eax, -0x38(%rbp)
               	movslq	-0x38(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	jge	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x40(%rbp)
               	movl	%eax, -0x48(%rbp)
               	movslq	-0x10(%rbp), %rdx
               	movq	0x28(%rsp), %rdx
               	addq	%rdx, %rdx
               	movzbq	(%rdx), %rax
               	xorq	$0x2e, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	movl	%eax, -0x50(%rbp)
               	movslq	-0x38(%rbp), %rbx
               	movabsq	$-0x1, %r11
               	imulq	%r11, %rbx
               	movl	%ebx, -0x38(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rbx
               	addq	$0x1, %rbx
               	movslq	%ebx, %rbx
               	movl	%ebx, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rbx
               	movq	0x28(%rsp), %rbx
               	addq	%rbx, %rbx
               	movzbq	(%rbx), %rax
               	cmpq	$0x30, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x118(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x38(%rbp), %rbx
               	movl	$0xa, %r11d
               	imulq	%r11, %rbx
               	movslq	%ebx, %rbx
               	movslq	-0x10(%rbp), %rax
               	movq	0x28(%rsp), %r15
               	addq	%rax, %r15
               	movzbq	(%r15), %rdx
               	subq	$0x30, %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rbx
               	movslq	%ebx, %rbx
               	movl	%ebx, -0x38(%rbp)
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rbx
               	movq	0x28(%rsp), %rbx
               	addq	%rbx, %rbx
               	movzbq	(%rbx), %rax
               	cmpq	$0x39, %rax
               	setle	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x118(%rbp)
               	jmp	<addr>
               	movq	-0x118(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %edx
               	movl	%edx, -0x48(%rbp)
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rdx
               	movq	0x28(%rsp), %rdx
               	addq	%rdx, %rdx
               	movzbq	(%rdx), %rax
               	xorq	$0x2a, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x40(%rbp), %rdx
               	movq	(%rdx), %rax
               	leaq	0x10(%rax), %r11
               	movq	%r11, (%rdx)
               	movslq	(%rax), %rdx
               	movl	%edx, -0x40(%rbp)
               	movslq	-0x40(%rbp), %rax
               	cmpq	$0x0, %rax
               	jge	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movl	%edx, -0x48(%rbp)
               	movl	%edx, -0x40(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rdx
               	addq	$0x1, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rdx
               	movq	0x28(%rsp), %rdx
               	addq	%rdx, %rdx
               	movzbq	(%rdx), %rax
               	cmpq	$0x30, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x120(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x40(%rbp), %rdx
               	movl	$0xa, %r11d
               	imulq	%r11, %rdx
               	movslq	%edx, %rdx
               	movslq	-0x10(%rbp), %rax
               	movq	0x28(%rsp), %rbx
               	addq	%rax, %rbx
               	movzbq	(%rbx), %r15
               	subq	$0x30, %r15
               	movslq	%r15d, %r15
               	addq	%r15, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, -0x40(%rbp)
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rdx
               	movq	0x28(%rsp), %rdx
               	addq	%rdx, %rdx
               	movzbq	(%rdx), %rax
               	cmpq	$0x39, %rax
               	setle	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x120(%rbp)
               	jmp	<addr>
               	movq	-0x120(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	movq	0x28(%rsp), %rax
               	addq	%rax, %rax
               	movzbq	(%rax), %r15
               	xorq	$0x6c, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x140(%rbp)
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	movq	0x28(%rsp), %rax
               	addq	%rax, %rax
               	movzbq	(%rax), %r15
               	movb	%r15b, -0x70(%rbp)
               	movzbq	-0x70(%rbp), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	movq	0x28(%rsp), %rax
               	addq	%rax, %rax
               	movzbq	(%rax), %r15
               	xorq	$0x68, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x140(%rbp)
               	jmp	<addr>
               	movq	-0x140(%rbp), %r15
               	movq	%r15, -0x138(%rbp)
               	cmpq	$0x0, %r15
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	movq	0x28(%rsp), %rax
               	addq	%rax, %rax
               	movzbq	(%rax), %r15
               	xorq	$0x7a, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x138(%rbp)
               	jmp	<addr>
               	movq	-0x138(%rbp), %r15
               	movq	%r15, -0x130(%rbp)
               	cmpq	$0x0, %r15
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	movq	0x28(%rsp), %rax
               	addq	%rax, %rax
               	movzbq	(%rax), %r15
               	xorq	$0x6a, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x130(%rbp)
               	jmp	<addr>
               	movq	-0x130(%rbp), %r15
               	movq	%r15, -0x128(%rbp)
               	cmpq	$0x0, %r15
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	movq	0x28(%rsp), %rax
               	addq	%rax, %rax
               	movzbq	(%rax), %r15
               	xorq	$0x74, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x128(%rbp)
               	jmp	<addr>
               	movq	-0x128(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	<addr>
               	jmp	<addr>
               	leaq	0x40(%rbp), %r15
               	movq	(%r15), %rax
               	leaq	0x10(%rax), %r11
               	movq	%r11, (%r15)
               	movslq	(%rax), %r15
               	movl	%r15d, -0x20(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0x28(%rbp)
               	movslq	-0x20(%rbp), %r15
               	cmpq	$0x0, %r15
               	jge	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x70(%rbp), %rax
               	xorq	$0x75, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x188(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	movl	%eax, -0x28(%rbp)
               	movslq	-0x20(%rbp), %r15
               	movabsq	$-0x1, %r11
               	imulq	%r11, %r15
               	movl	%r15d, -0x20(%rbp)
               	jmp	<addr>
               	leaq	-0x90(%rbp), %rbx
               	movl	$0x1f, %r15d
               	movslq	-0x20(%rbp), %r12
               	movl	$0xa, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	callq	<addr>
               	movl	%eax, -0x18(%rbp)
               	movslq	-0x18(%rbp), %r14
               	subq	%r14, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x60(%rbp)
               	movslq	-0x28(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	movslq	-0x60(%rbp), %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x60(%rbp)
               	jmp	<addr>
               	movslq	-0x48(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	<addr>
               	movslq	-0x40(%rbp), %r14
               	movq	%r14, -0x148(%rbp)
               	jmp	<addr>
               	xorq	%r14, %r14
               	movq	%r14, -0x148(%rbp)
               	jmp	<addr>
               	movq	-0x148(%rbp), %r14
               	movl	%r14d, -0xa0(%rbp)
               	xorq	%r15, %r15
               	movl	%r15d, -0xa8(%rbp)
               	movslq	-0x60(%rbp), %r14
               	movslq	-0x28(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x150(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x150(%rbp)
               	jmp	<addr>
               	movq	-0x150(%rbp), %rax
               	subq	%rax, %r14
               	movslq	%r14d, %r14
               	movslq	-0xa0(%rbp), %rax
               	cmpq	%rax, %r14
               	jge	<addr>
               	movslq	-0xa0(%rbp), %rax
               	movslq	-0x60(%rbp), %r14
               	movslq	-0x28(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x38(%rbp), %r14
               	movslq	-0x60(%rbp), %rax
               	cmpq	%rax, %r14
               	jle	<addr>
               	jmp	<addr>
               	movl	$0x1, %r12d
               	movq	%r12, -0x158(%rbp)
               	jmp	<addr>
               	xorq	%r12, %r12
               	movq	%r12, -0x158(%rbp)
               	jmp	<addr>
               	movq	-0x158(%rbp), %r12
               	subq	%r12, %r14
               	movslq	%r14d, %r14
               	subq	%r14, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0xa8(%rbp)
               	movslq	-0x60(%rbp), %r14
               	movslq	-0xa8(%rbp), %rax
               	addq	%rax, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x60(%rbp)
               	jmp	<addr>
               	movslq	-0x38(%rbp), %rax
               	movslq	-0x60(%rbp), %r14
               	subq	%r14, %rax
               	movslq	%eax, %rax
               	movq	%rax, -0x160(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x160(%rbp)
               	jmp	<addr>
               	movq	-0x160(%rbp), %rax
               	movl	%eax, -0x68(%rbp)
               	movslq	-0x58(%rbp), %r14
               	movq	%r14, -0x170(%rbp)
               	cmpq	$0x0, %r14
               	je	<addr>
               	movslq	-0x48(%rbp), %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x170(%rbp)
               	jmp	<addr>
               	movq	-0x170(%rbp), %rax
               	movq	%rax, -0x168(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	-0x50(%rbp), %r14
               	cmpq	$0x0, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x168(%rbp)
               	jmp	<addr>
               	movq	-0x168(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	movl	$0x30, %eax
               	movq	%rax, -0x178(%rbp)
               	jmp	<addr>
               	movl	$0x20, %eax
               	movq	%rax, -0x178(%rbp)
               	jmp	<addr>
               	movq	-0x178(%rbp), %rax
               	movb	%al, -0xb0(%rbp)
               	movslq	-0x50(%rbp), %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0x28(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x68(%rbp), %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	leaq	-0x8(%rbp), %rbx
               	movzbq	-0xb0(%rbp), %r14
               	movq	%rbx, %rdx
               	movq	%r14, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	-0x68(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x68(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r12
               	movl	$0x2d, %r14d
               	movq	%r12, %rdx
               	movq	%r14, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0xa8(%rbp), %r14
               	cmpq	$0x0, %r14
               	jle	<addr>
               	leaq	-0x8(%rbp), %rbx
               	movl	$0x30, %r15d
               	movq	%rbx, %rdx
               	movq	%r15, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	-0xa8(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0xa8(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x1f, %rax
               	jge	<addr>
               	leaq	-0x8(%rbp), %r12
               	leaq	-0x90(%rbp), %rax
               	movslq	-0x18(%rbp), %rbx
               	addq	%rbx, %rax
               	movzbq	(%rax), %r15
               	movq	%r12, %rdx
               	movq	%r15, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	-0x18(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x50(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x68(%rbp), %r15
               	cmpq	$0x0, %r15
               	jle	<addr>
               	leaq	-0x8(%rbp), %rbx
               	movl	$0x20, %r14d
               	movq	%rbx, %rdx
               	movq	%r14, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	-0x68(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x68(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x70(%rbp), %r14
               	xorq	$0x78, %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x188(%rbp)
               	jmp	<addr>
               	movq	-0x188(%rbp), %r14
               	movq	%r14, -0x180(%rbp)
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movzbq	-0x70(%rbp), %rax
               	xorq	$0x58, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x180(%rbp)
               	jmp	<addr>
               	movq	-0x180(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	0x40(%rbp), %r14
               	movq	(%r14), %rax
               	leaq	0x10(%rax), %r11
               	movq	%r11, (%r14)
               	movslq	(%rax), %r14
               	movl	%r14d, -0x20(%rbp)
               	leaq	-0x90(%rbp), %r12
               	movl	$0x1f, %r15d
               	movslq	-0x20(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movzbq	-0x70(%rbp), %rbx
               	xorq	$0x75, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x70(%rbp), %rax
               	xorq	$0x70, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0xa, %eax
               	movq	%rax, -0x190(%rbp)
               	jmp	<addr>
               	movl	$0x10, %eax
               	movq	%rax, -0x190(%rbp)
               	jmp	<addr>
               	movq	-0x190(%rbp), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rsi
               	movq	0x20(%rsp), %rdx
               	callq	<addr>
               	movl	%eax, -0x18(%rbp)
               	movl	$0x1f, %r14d
               	movslq	-0x18(%rbp), %rax
               	subq	%rax, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x60(%rbp)
               	movslq	-0x48(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	-0x40(%rbp), %r14
               	movq	%r14, -0x198(%rbp)
               	jmp	<addr>
               	xorq	%r14, %r14
               	movq	%r14, -0x198(%rbp)
               	jmp	<addr>
               	movq	-0x198(%rbp), %r14
               	movl	%r14d, -0xb8(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0xc0(%rbp)
               	movslq	-0x60(%rbp), %r14
               	movslq	-0xb8(%rbp), %rax
               	cmpq	%rax, %r14
               	jge	<addr>
               	movslq	-0xb8(%rbp), %rax
               	movslq	-0x60(%rbp), %r14
               	subq	%r14, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0xc0(%rbp)
               	movslq	-0xc0(%rbp), %r15
               	addq	%r15, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x60(%rbp)
               	jmp	<addr>
               	movslq	-0x38(%rbp), %r14
               	movslq	-0x60(%rbp), %r15
               	cmpq	%r15, %r14
               	jle	<addr>
               	movslq	-0x38(%rbp), %r15
               	movslq	-0x60(%rbp), %r14
               	subq	%r14, %r15
               	movslq	%r15d, %r15
               	movq	%r15, -0x1a0(%rbp)
               	jmp	<addr>
               	xorq	%r15, %r15
               	movq	%r15, -0x1a0(%rbp)
               	jmp	<addr>
               	movq	-0x1a0(%rbp), %r15
               	movl	%r15d, -0x68(%rbp)
               	movslq	-0x58(%rbp), %r14
               	movq	%r14, -0x1b0(%rbp)
               	cmpq	$0x0, %r14
               	je	<addr>
               	movslq	-0x48(%rbp), %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x1b0(%rbp)
               	jmp	<addr>
               	movq	-0x1b0(%rbp), %r15
               	movq	%r15, -0x1a8(%rbp)
               	cmpq	$0x0, %r15
               	je	<addr>
               	movslq	-0x50(%rbp), %r14
               	cmpq	$0x0, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x1a8(%rbp)
               	jmp	<addr>
               	movq	-0x1a8(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	movl	$0x30, %r15d
               	movq	%r15, -0x1b8(%rbp)
               	jmp	<addr>
               	movl	$0x20, %r15d
               	movq	%r15, -0x1b8(%rbp)
               	jmp	<addr>
               	movq	-0x1b8(%rbp), %r15
               	movb	%r15b, -0xc8(%rbp)
               	movslq	-0x50(%rbp), %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x68(%rbp), %r15
               	cmpq	$0x0, %r15
               	jle	<addr>
               	leaq	-0x8(%rbp), %rbx
               	movzbq	-0xc8(%rbp), %r14
               	movq	%rbx, %rdx
               	movq	%r14, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	-0x68(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x68(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0xc0(%rbp), %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	leaq	-0x8(%rbp), %r15
               	movl	$0x30, %r14d
               	movq	%r15, %rdx
               	movq	%r14, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	-0xc0(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0xc0(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x1f, %rax
               	jge	<addr>
               	leaq	-0x8(%rbp), %rbx
               	leaq	-0x90(%rbp), %rax
               	movslq	-0x18(%rbp), %r15
               	addq	%r15, %rax
               	movzbq	(%rax), %r14
               	movq	%rbx, %rdx
               	movq	%r14, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	-0x18(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x50(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x68(%rbp), %r14
               	cmpq	$0x0, %r14
               	jle	<addr>
               	leaq	-0x8(%rbp), %r15
               	movl	$0x20, %r12d
               	movq	%r15, %rdx
               	movq	%r12, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	-0x68(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x68(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x40(%rbp), %r12
               	movq	(%r12), %rax
               	leaq	0x10(%rax), %r11
               	movq	%r11, (%r12)
               	movslq	(%rax), %r12
               	movl	%r12d, -0x20(%rbp)
               	leaq	-0x8(%rbp), %rbx
               	movl	$0x30, %r14d
               	movq	%rbx, %rdx
               	movq	%r14, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	leaq	-0x8(%rbp), %r15
               	movl	$0x78, %r12d
               	movq	%r15, %rdx
               	movq	%r12, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movl	$0xf, %eax
               	movl	%eax, -0x18(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x70(%rbp), %r12
               	xorq	$0x63, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x0, %rax
               	jl	<addr>
               	movslq	-0x20(%rbp), %r12
               	movslq	-0x18(%rbp), %rax
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	sarq	%cl, %r12
               	andq	$0xf, %r12
               	movl	%r12d, -0x30(%rbp)
               	movslq	-0x30(%rbp), %rax
               	cmpq	$0xa, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r12
               	addq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x10(%rbp)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rbx
               	movslq	-0x30(%rbp), %rax
               	addq	$0x30, %rax
               	movslq	%eax, %r12
               	movq	%rbx, %rdx
               	movq	%r12, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	jmp	<addr>
               	movslq	-0x18(%rbp), %r12
               	subq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x18(%rbp)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r15
               	movslq	-0x30(%rbp), %rax
               	addq	$0x61, %rax
               	movslq	%eax, %rax
               	subq	$0xa, %rax
               	movslq	%eax, %r12
               	movq	%r15, %rdx
               	movq	%r12, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	jmp	<addr>
               	leaq	0x40(%rbp), %rax
               	movq	(%rax), %r12
               	leaq	0x10(%r12), %r11
               	movq	%r11, (%rax)
               	movslq	(%r12), %rax
               	movl	%eax, -0xd0(%rbp)
               	movslq	-0x38(%rbp), %r12
               	cmpq	$0x1, %r12
               	jle	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x70(%rbp), %rax
               	xorq	$0x73, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0x38(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movq	%rax, -0x1c0(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x1c0(%rbp)
               	jmp	<addr>
               	movq	-0x1c0(%rbp), %rax
               	movl	%eax, -0x68(%rbp)
               	movslq	-0x50(%rbp), %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r15
               	movslq	-0xd0(%rbp), %r14
               	movq	%r15, %rdx
               	movq	%r14, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	-0x50(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x68(%rbp), %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	leaq	-0x8(%rbp), %rbx
               	movl	$0x20, %r12d
               	movq	%rbx, %rdx
               	movq	%r12, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	-0x68(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x68(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x68(%rbp), %r14
               	cmpq	$0x0, %r14
               	jle	<addr>
               	leaq	-0x8(%rbp), %rbx
               	movl	$0x20, %r12d
               	movq	%rbx, %rdx
               	movq	%r12, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	-0x68(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x68(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x40(%rbp), %r12
               	movq	(%r12), %rax
               	leaq	0x10(%rax), %r11
               	movq	%r11, (%r12)
               	movq	(%rax), %r12
               	movq	%r12, -0x98(%rbp)
               	movq	-0x98(%rbp), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x70(%rbp), %rax
               	xorq	$0x25, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	%r12, -0x98(%rbp)
               	jmp	<addr>
               	xorq	%r12, %r12
               	movl	%r12d, -0x60(%rbp)
               	jmp	<addr>
               	movq	-0x98(%rbp), %r12
               	movslq	-0x60(%rbp), %rax
               	addq	%rax, %r12
               	movzbq	(%r12), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	-0x60(%rbp), %r12
               	addq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x60(%rbp)
               	jmp	<addr>
               	movslq	-0x48(%rbp), %r12
               	movq	%r12, -0x1c8(%rbp)
               	cmpq	$0x0, %r12
               	je	<addr>
               	movslq	-0x40(%rbp), %rax
               	movslq	-0x60(%rbp), %r12
               	cmpq	%r12, %rax
               	setl	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x1c8(%rbp)
               	jmp	<addr>
               	movq	-0x1c8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	-0x40(%rbp), %r12
               	movl	%r12d, -0x60(%rbp)
               	jmp	<addr>
               	movslq	-0x38(%rbp), %r12
               	movslq	-0x60(%rbp), %rax
               	cmpq	%rax, %r12
               	jle	<addr>
               	movslq	-0x38(%rbp), %rax
               	movslq	-0x60(%rbp), %r12
               	subq	%r12, %rax
               	movslq	%eax, %rax
               	movq	%rax, -0x1d0(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x1d0(%rbp)
               	jmp	<addr>
               	movq	-0x1d0(%rbp), %rax
               	movl	%eax, -0x68(%rbp)
               	movslq	-0x50(%rbp), %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x68(%rbp), %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	leaq	-0x8(%rbp), %r15
               	movl	$0x20, %r12d
               	movq	%r15, %rdx
               	movq	%r12, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	-0x68(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x68(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	movslq	-0x60(%rbp), %r12
               	cmpq	%r12, %rax
               	jge	<addr>
               	leaq	-0x8(%rbp), %rbx
               	movq	-0x98(%rbp), %rax
               	movslq	-0x18(%rbp), %r15
               	addq	%r15, %rax
               	movzbq	(%rax), %r12
               	movq	%rbx, %rdx
               	movq	%r12, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	-0x18(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x50(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x68(%rbp), %r12
               	cmpq	$0x0, %r12
               	jle	<addr>
               	leaq	-0x8(%rbp), %r15
               	movl	$0x20, %r14d
               	movq	%r15, %rdx
               	movq	%r14, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	-0x68(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x68(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rbx
               	movl	$0x25, %r14d
               	movq	%rbx, %rdx
               	movq	%r14, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x70(%rbp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r15
               	movl	$0x25, %r14d
               	movq	%r15, %rdx
               	movq	%r14, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	leaq	-0x8(%rbp), %rbx
               	movzbq	-0x70(%rbp), %r12
               	movq	%rbx, %rdx
               	movq	%r12, %rcx
               	movq	0x38(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r12
               	movq	0x30(%rsp), %r10
               	cmpq	%r10, %r12
               	jge	<addr>
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	movslq	-0x8(%rbp), %rax
               	movq	0x38(%rsp), %rax
               	addq	%rax, %rax
               	xorq	%r12, %r12
               	movb	%r12b, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x30(%rsp), %r12
               	subq	$0x1, %r12
               	movslq	%r12d, %r12
               	movq	0x38(%rsp), %rbx
               	addq	%r12, %rbx
               	xorq	%r12, %r12
               	movb	%r12b, (%rbx)
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x8(%rbp), %r11
               	leaq	0x30(%rbp), %r9
               	leaq	0x10(%r9), %r10
               	movq	%r10, (%r11)
               	movq	0x10(%rbp), %rbx
               	movslq	0x20(%rbp), %r12
               	movq	0x30(%rbp), %r14
               	movq	-0x8(%rbp), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0x8(%rbp), %r15
               	movslq	%eax, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x40(%rbp), %rbx
               	movl	$0x40, %r12d
               	leaq	<rip>, %r14
               	movl	$0x2a, %r10d
               	movq	%r10, 0x28(%rsp)
               	movl	$0x63, %r15d
               	subq	$0x10, %rsp
               	movq	%r15, (%rsp)
               	movq	0x38(%rsp), %r10
               	subq	$0x10, %rsp
               	movq	%r10, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r14, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	<addr>
               	addq	$0x50, %rsp
               	leaq	-0x40(%rbp), %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	leaq	-0x40(%rbp), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
