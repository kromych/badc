
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
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	movq	(%rax), %rax
               	movq	%rax, (%rdi)
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
               	subq	$0x1f0, %rsp            # imm = 0x1F0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movslq	%esi, %r12
               	movq	%rdx, %r14
               	movq	%rcx, %rdi
               	movq	%rdi, 0x40(%rbp)
               	xorq	%rsi, %rsi
               	movl	%esi, -0x8(%rbp)
               	movl	%esi, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rsi
               	addq	%r14, %rsi
               	movzbq	(%rsi), %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movslq	-0x10(%rbp), %rdi
               	addq	%r14, %rdi
               	movzbq	(%rdi), %rdi
               	movb	%dil, -0x70(%rbp)
               	movzbq	-0x70(%rbp), %rsi
               	xorq	$0x25, %rsi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x0, %r12
               	jle	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movzbq	-0x70(%rbp), %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
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
               	xorq	%rdx, %rdx
               	movl	%edx, -0x50(%rbp)
               	movl	%edx, -0x58(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rdx
               	addq	%r14, %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x2d, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0x110(%rbp)
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2d, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x38(%rbp)
               	movslq	-0x10(%rbp), %rdx
               	addq	%r14, %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x2a, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
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
               	movslq	-0x10(%rbp), %rdx
               	addq	%r14, %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x2b, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0x108(%rbp)
               	jmp	<addr>
               	movq	-0x108(%rbp), %rdx
               	movq	%rdx, -0x100(%rbp)
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
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
               	movslq	-0x10(%rbp), %rdx
               	addq	%r14, %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x23, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0xf8(%rbp)
               	jmp	<addr>
               	movq	-0xf8(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %edx
               	movl	%edx, -0x50(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rdx
               	addq	%r14, %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x30, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movl	$0x1, %eax
               	movl	%eax, -0x58(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x40(%rbp), %rax
               	movq	(%rax), %rdx
               	leaq	0x10(%rdx), %r11
               	movq	%r11, (%rax)
               	movslq	(%rdx), %rdx
               	movl	%edx, -0x38(%rbp)
               	movslq	-0x38(%rbp), %rax
               	cmpq	$0x0, %rax
               	jge	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movl	%edx, -0x40(%rbp)
               	movl	%edx, -0x48(%rbp)
               	movslq	-0x10(%rbp), %rdi
               	addq	%r14, %rdi
               	movzbq	(%rdi), %rdi
               	xorq	$0x2e, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %edx
               	movl	%edx, -0x50(%rbp)
               	movslq	-0x38(%rbp), %rax
               	movabsq	$-0x1, %r11
               	imulq	%r11, %rax
               	movl	%eax, -0x38(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x118(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x38(%rbp), %rax
               	movl	$0xa, %r11d
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	movslq	-0x10(%rbp), %rdx
               	movq	%r14, %rdi
               	addq	%rdx, %rdi
               	movzbq	(%rdi), %rdi
               	subq	$0x30, %rdi
               	movslq	%edi, %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x38(%rbp)
               	addq	$0x1, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rdx
               	addq	%r14, %rdx
               	movzbq	(%rdx), %rdx
               	cmpq	$0x39, %rdx
               	setle	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0x118(%rbp)
               	jmp	<addr>
               	movq	-0x118(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %edx
               	movl	%edx, -0x48(%rbp)
               	movslq	-0x10(%rbp), %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rdx
               	addq	%r14, %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x2a, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x40(%rbp), %rdi
               	movq	(%rdi), %rdx
               	leaq	0x10(%rdx), %r11
               	movq	%r11, (%rdi)
               	movslq	(%rdx), %rdx
               	movl	%edx, -0x40(%rbp)
               	movslq	-0x40(%rbp), %rdi
               	cmpq	$0x0, %rdi
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
               	addq	%r14, %rdx
               	movzbq	(%rdx), %rdx
               	cmpq	$0x30, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0x120(%rbp)
               	cmpq	$0x0, %rdx
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x40(%rbp), %rdx
               	movl	$0xa, %r11d
               	imulq	%r11, %rdx
               	movslq	%edx, %rdx
               	movslq	-0x10(%rbp), %rdi
               	movq	%r14, %rax
               	addq	%rdi, %rax
               	movzbq	(%rax), %rax
               	subq	$0x30, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, -0x40(%rbp)
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rdi
               	addq	%r14, %rdi
               	movzbq	(%rdi), %rdi
               	cmpq	$0x39, %rdi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x120(%rbp)
               	jmp	<addr>
               	movq	-0x120(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rdi
               	addq	%r14, %rdi
               	movzbq	(%rdi), %rdi
               	xorq	$0x6c, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x140(%rbp)
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	movb	%al, -0x70(%rbp)
               	movzbq	-0x70(%rbp), %rdi
               	xorq	$0x64, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x68, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x140(%rbp)
               	jmp	<addr>
               	movq	-0x140(%rbp), %rax
               	movq	%rax, -0x138(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rdi
               	addq	%r14, %rdi
               	movzbq	(%rdi), %rdi
               	xorq	$0x7a, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x138(%rbp)
               	jmp	<addr>
               	movq	-0x138(%rbp), %rdi
               	movq	%rdi, -0x130(%rbp)
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x6a, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x130(%rbp)
               	jmp	<addr>
               	movq	-0x130(%rbp), %rax
               	movq	%rax, -0x128(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rdi
               	addq	%r14, %rdi
               	movzbq	(%rdi), %rdi
               	xorq	$0x74, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x128(%rbp)
               	jmp	<addr>
               	movq	-0x128(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	jmp	<addr>
               	leaq	0x40(%rbp), %rax
               	movq	(%rax), %rdi
               	leaq	0x10(%rdi), %r11
               	movq	%r11, (%rax)
               	movslq	(%rdi), %rdi
               	movl	%edi, -0x20(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0x28(%rbp)
               	movslq	-0x20(%rbp), %rdi
               	cmpq	$0x0, %rdi
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
               	movslq	-0x20(%rbp), %rdi
               	movabsq	$-0x1, %r11
               	imulq	%r11, %rdi
               	movl	%edi, -0x20(%rbp)
               	jmp	<addr>
               	leaq	-0x90(%rbp), %rdi
               	movl	$0x1f, %r15d
               	movslq	-0x20(%rbp), %rdx
               	movl	$0xa, %ecx
               	movq	%r15, %rsi
               	callq	<addr>
               	movl	%eax, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rdx
               	subq	%rdx, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x60(%rbp)
               	movslq	-0x28(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movslq	-0x60(%rbp), %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x60(%rbp)
               	jmp	<addr>
               	movslq	-0x48(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	<addr>
               	movslq	-0x40(%rbp), %rdx
               	movq	%rdx, -0x148(%rbp)
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, -0x148(%rbp)
               	jmp	<addr>
               	movq	-0x148(%rbp), %rdx
               	movl	%edx, -0xa0(%rbp)
               	xorq	%r15, %r15
               	movl	%r15d, -0xa8(%rbp)
               	movslq	-0x60(%rbp), %rdx
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
               	subq	%rax, %rdx
               	movslq	%edx, %rdx
               	movslq	-0xa0(%rbp), %rax
               	cmpq	%rax, %rdx
               	jge	<addr>
               	movslq	-0xa0(%rbp), %rax
               	movslq	-0x60(%rbp), %rdx
               	movslq	-0x28(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x38(%rbp), %rdx
               	movslq	-0x60(%rbp), %rax
               	cmpq	%rax, %rdx
               	jle	<addr>
               	jmp	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, -0x158(%rbp)
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	movq	%rdi, -0x158(%rbp)
               	jmp	<addr>
               	movq	-0x158(%rbp), %rdi
               	subq	%rdi, %rdx
               	movslq	%edx, %rdx
               	subq	%rdx, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0xa8(%rbp)
               	movslq	-0x60(%rbp), %rdx
               	movslq	-0xa8(%rbp), %rax
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, -0x60(%rbp)
               	jmp	<addr>
               	movslq	-0x38(%rbp), %rax
               	movslq	-0x60(%rbp), %rdx
               	subq	%rdx, %rax
               	movslq	%eax, %rax
               	movq	%rax, -0x160(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x160(%rbp)
               	jmp	<addr>
               	movq	-0x160(%rbp), %rax
               	movl	%eax, -0x68(%rbp)
               	movslq	-0x58(%rbp), %rdx
               	movq	%rdx, -0x170(%rbp)
               	cmpq	$0x0, %rdx
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
               	movslq	-0x50(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0x168(%rbp)
               	jmp	<addr>
               	movq	-0x168(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0x30, %eax
               	movq	%rax, -0x178(%rbp)
               	jmp	<addr>
               	movl	$0x20, %eax
               	movq	%rax, -0x178(%rbp)
               	jmp	<addr>
               	movq	-0x178(%rbp), %rax
               	movb	%al, -0xb0(%rbp)
               	movslq	-0x50(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0x28(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x68(%rbp), %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movzbq	-0xb0(%rbp), %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	-0x68(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x68(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x2d, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0xa8(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x30, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
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
               	leaq	-0x8(%rbp), %rdx
               	leaq	-0x90(%rbp), %rax
               	movslq	-0x18(%rbp), %rdi
               	addq	%rdi, %rax
               	movzbq	(%rax), %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
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
               	movslq	-0x68(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x20, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	-0x68(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x68(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x70(%rbp), %rdx
               	xorq	$0x78, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0x188(%rbp)
               	jmp	<addr>
               	movq	-0x188(%rbp), %rdx
               	movq	%rdx, -0x180(%rbp)
               	cmpq	$0x0, %rdx
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
               	leaq	0x40(%rbp), %rdx
               	movq	(%rdx), %rax
               	leaq	0x10(%rax), %r11
               	movq	%r11, (%rdx)
               	movslq	(%rax), %rax
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x90(%rbp), %rdi
               	movl	$0x1f, %esi
               	movslq	-0x20(%rbp), %rdx
               	movzbq	-0x70(%rbp), %r15
               	xorq	$0x75, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
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
               	movq	-0x190(%rbp), %rcx
               	callq	<addr>
               	movl	%eax, -0x18(%rbp)
               	movl	$0x1f, %edx
               	movslq	-0x18(%rbp), %rax
               	subq	%rax, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, -0x60(%rbp)
               	movslq	-0x48(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	-0x40(%rbp), %rdx
               	movq	%rdx, -0x198(%rbp)
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, -0x198(%rbp)
               	jmp	<addr>
               	movq	-0x198(%rbp), %rdx
               	movl	%edx, -0xb8(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0xc0(%rbp)
               	movslq	-0x60(%rbp), %rdx
               	movslq	-0xb8(%rbp), %rax
               	cmpq	%rax, %rdx
               	jge	<addr>
               	movslq	-0xb8(%rbp), %rax
               	movslq	-0x60(%rbp), %rdx
               	subq	%rdx, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0xc0(%rbp)
               	movslq	-0xc0(%rbp), %rsi
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, -0x60(%rbp)
               	jmp	<addr>
               	movslq	-0x38(%rbp), %rdx
               	movslq	-0x60(%rbp), %rsi
               	cmpq	%rsi, %rdx
               	jle	<addr>
               	movslq	-0x38(%rbp), %rsi
               	movslq	-0x60(%rbp), %rdx
               	subq	%rdx, %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, -0x1a0(%rbp)
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	movq	%rsi, -0x1a0(%rbp)
               	jmp	<addr>
               	movq	-0x1a0(%rbp), %rsi
               	movl	%esi, -0x68(%rbp)
               	movslq	-0x58(%rbp), %rdx
               	movq	%rdx, -0x1b0(%rbp)
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movslq	-0x48(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x1b0(%rbp)
               	jmp	<addr>
               	movq	-0x1b0(%rbp), %rsi
               	movq	%rsi, -0x1a8(%rbp)
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movslq	-0x50(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0x1a8(%rbp)
               	jmp	<addr>
               	movq	-0x1a8(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0x30, %esi
               	movq	%rsi, -0x1b8(%rbp)
               	jmp	<addr>
               	movl	$0x20, %esi
               	movq	%rsi, -0x1b8(%rbp)
               	jmp	<addr>
               	movq	-0x1b8(%rbp), %rsi
               	movb	%sil, -0xc8(%rbp)
               	movslq	-0x50(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x68(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movzbq	-0xc8(%rbp), %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
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
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x30, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
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
               	leaq	-0x8(%rbp), %rdx
               	leaq	-0x90(%rbp), %rax
               	movslq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
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
               	movslq	-0x68(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x20, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	-0x68(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x68(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x40(%rbp), %rdx
               	movq	(%rdx), %rax
               	leaq	0x10(%rax), %r11
               	movq	%r11, (%rdx)
               	movslq	(%rax), %rax
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x30, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x78, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movl	$0xf, %eax
               	movl	%eax, -0x18(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x70(%rbp), %rdx
               	xorq	$0x63, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x0, %rax
               	jl	<addr>
               	movslq	-0x20(%rbp), %rdx
               	movslq	-0x18(%rbp), %rax
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	sarq	%cl, %rdx
               	andq	$0xf, %rdx
               	movl	%edx, -0x30(%rbp)
               	movslq	-0x30(%rbp), %rax
               	cmpq	$0xa, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rdx
               	addq	$0x1, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, -0x10(%rbp)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movslq	-0x30(%rbp), %rax
               	addq	$0x30, %rax
               	movslq	%eax, %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rdx
               	subq	$0x1, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, -0x18(%rbp)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movslq	-0x30(%rbp), %rax
               	addq	$0x61, %rax
               	movslq	%eax, %rax
               	subq	$0xa, %rax
               	movslq	%eax, %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	jmp	<addr>
               	leaq	0x40(%rbp), %rax
               	movq	(%rax), %rdx
               	leaq	0x10(%rdx), %r11
               	movq	%r11, (%rax)
               	movslq	(%rdx), %rdx
               	movl	%edx, -0xd0(%rbp)
               	movslq	-0x38(%rbp), %rax
               	cmpq	$0x1, %rax
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
               	movslq	-0x38(%rbp), %rdx
               	subq	$0x1, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, -0x1c0(%rbp)
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, -0x1c0(%rbp)
               	jmp	<addr>
               	movq	-0x1c0(%rbp), %rdx
               	movl	%edx, -0x68(%rbp)
               	movslq	-0x50(%rbp), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movslq	-0xd0(%rbp), %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	-0x50(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x68(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x20, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
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
               	movslq	-0x68(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x20, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	-0x68(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x68(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x40(%rbp), %rdx
               	movq	(%rdx), %rax
               	leaq	0x10(%rax), %r11
               	movq	%r11, (%rdx)
               	movq	(%rax), %rax
               	movq	%rax, -0x98(%rbp)
               	movq	-0x98(%rbp), %rdx
               	cmpq	$0x0, %rdx
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
               	leaq	<rip>, %rax
               	movq	%rax, -0x98(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x60(%rbp)
               	jmp	<addr>
               	movq	-0x98(%rbp), %rax
               	movslq	-0x60(%rbp), %rdx
               	addq	%rdx, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	-0x60(%rbp), %rdx
               	addq	$0x1, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, -0x60(%rbp)
               	jmp	<addr>
               	movslq	-0x48(%rbp), %rdx
               	movq	%rdx, -0x1c8(%rbp)
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movslq	-0x40(%rbp), %rax
               	movslq	-0x60(%rbp), %rdx
               	cmpq	%rdx, %rax
               	setl	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x1c8(%rbp)
               	jmp	<addr>
               	movq	-0x1c8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	-0x40(%rbp), %rdx
               	movl	%edx, -0x60(%rbp)
               	jmp	<addr>
               	movslq	-0x38(%rbp), %rdx
               	movslq	-0x60(%rbp), %rax
               	cmpq	%rax, %rdx
               	jle	<addr>
               	movslq	-0x38(%rbp), %rax
               	movslq	-0x60(%rbp), %rdx
               	subq	%rdx, %rax
               	movslq	%eax, %rax
               	movq	%rax, -0x1d0(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x1d0(%rbp)
               	jmp	<addr>
               	movq	-0x1d0(%rbp), %rax
               	movl	%eax, -0x68(%rbp)
               	movslq	-0x50(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x68(%rbp), %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x20, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	-0x68(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x68(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	movslq	-0x60(%rbp), %rdx
               	cmpq	%rdx, %rax
               	jge	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movq	-0x98(%rbp), %rax
               	movslq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
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
               	movslq	-0x68(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	jle	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x20, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	-0x68(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x68(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x25, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x70(%rbp), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x25, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movzbq	-0x70(%rbp), %rcx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	cmpq	%r12, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1f0, %rsp            # imm = 0x1F0
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	movslq	-0x8(%rbp), %rax
               	addq	%rbx, %rax
               	xorq	%rdx, %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	subq	$0x1, %r12
               	movslq	%r12d, %r12
               	addq	%r12, %rbx
               	xorq	%r12, %r12
               	movb	%r12b, (%rbx)
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	0x30(%rbp), %r9
               	leaq	0x10(%r9), %r10
               	movq	%r10, (%r11)
               	movq	0x10(%rbp), %rdi
               	movslq	0x20(%rbp), %rsi
               	movq	0x30(%rbp), %rdx
               	movq	-0x8(%rbp), %rcx
               	callq	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movslq	%eax, %rsi
               	movq	%rsi, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movl	$0x2a, %ecx
               	movl	$0x63, %r8d
               	subq	$0x10, %rsp
               	movq	%r8, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rcx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	addq	$0x50, %rsp
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x40(%rbp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
